# frozen_string_literal: true

require 'rails/generators/migration'
require 'generators/allow_me/helpers'

module AllowMe
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      include AllowMe::Generators::Helpers

      source_root File.expand_path(__dir__)

      argument :submodules, optional: true, type: :array, banner: 'submodules'
      argument :models, optional: true, type: :array, banner: 'models'
      argument :roles, optional: true, type: :array, banner: 'roles'

      # Copy the initializer file to config/initializers folder.
      def copy_initializer_file
        template 'templates/initializer.rb', allow_me_config_path
      end

      def configure_initializer_file
        # Add submodules to the initializer file.
        return unless submodules

        submodule_names = submodules.collect { |submodule| ":#{submodule}" }

        gsub_file allow_me_config_path, /submodules = \[.*\]/ do |str|
          current_submodule_names = (str =~ /\[(.*)\]/ ? Regexp.last_match(1) : '').delete(' ').split(',')
          "submodules = [#{(current_submodule_names | submodule_names).join(", ")}]"
        end
      end

      # Generate User model - or model(s) based on name passed while initializing gem -
      # and call injecting method on them
      def configure_model
        model_class_names.each do |model_class_name|
          generate "model #{model_class_name} --skip-migration"
        end
      end

      # Inject allow_me_to_permit! method to User model(s)
      def inject_allow_me_to_models
        model_class_names.each do |model_class_name|
          indents = '  ' * (namespaced? ? 2 : 1)

          inject_into_class(model_path(model_class_name), model_class_name, "#{indents}allow_me_to_permit!\n")
        end
      end

      # Generate Admin/Role model - or model(s) based on data passed while initializing gem -
      # and other needed role handling models, and call injecting method on them
      def configure_roles
        role_related_models.each do |model|
          generate "model #{model} --skip-migration"
        end
      end

      def inject_allow_me_to_role_models
        indents = '  ' * (namespaced? ? 2 : 1)

        inject_into_class(model_path(role_class_name), role_class_name, "#{indents}allow_me_to_rule!\n")
      end

      # Copy the migrations files to db/migrate folder
      def copy_migration_files
        # Copy core migration file in all cases
        return unless defined?(ActiveRecord)

        # Role migration
        migration_template 'templates/migration/allow_me.rb', 'db/migrate/allow_me.allow_me_core.rb'
      end

      def inject_allow_me_to_role_controllers
        # FIXME: injectt controller modules to
      end

      def create_view
        # FIXME: add in controller to look for default view from AllowMe
        # template 'views/roles/new.html.haml', 'app/views/admin/roles/new.html.haml'
      end

      def add_routes
        # FIXME: check for current routing and add accordingly
        # route needed_routing
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

      def basic_generator?
        options[:models].blank?
      end
    end
  end
end
