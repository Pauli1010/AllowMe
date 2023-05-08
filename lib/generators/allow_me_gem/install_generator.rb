class AllowMeGem::InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  source_root File.expand_path("../templates", __FILE__)

  def create_initializer_file
    template 'initializer.rb', 'config/initializers/allow_me.rb'
  end

  def initialize_models
    defined_models.each do |model_class_name|
      template "models/#{model_class_name}.rb", "app/models/#{model_class_name}.rb"
    end
  end

  # Copy the migrations files to db/migrate folder
  def copy_migration_files
    # Copy core migration file in all cases
    return unless defined?(ActiveRecord)

    migration_template 'migration/allow_me.rb', 'db/migrate/allow_me.allow_me_core.rb', migration_class_name: migration_class_name
  end

  def create_controller
    template 'controllers/admin/roles_controller.rb', 'app/controllers/admin/roles_controller.rb'
  end

  def create_view
    template 'views/roles/new.html.haml', 'app/views/admin/roles/new.html.haml'
  end

  def add_routes
    route needed_routing
  end

  def defined_models
    [:role]
  end

  def needed_routing
    "namespace :admin do
      resources :roles, only: [:new, :create]
    end"
  end
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      sleep 1 # make sure each time we get a different timestamp
      Time.new.utc.strftime('%Y%m%d%H%M%S')
    else
      format('%.3d', (current_migration_number(dirname) + 1))
    end
  end

  def migration_class_name
    if Rails::VERSION::MAJOR >= 5
      "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
    else
      ''
    end
  end
end