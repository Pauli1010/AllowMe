class AllowMe < ActiveRecord::Migration<%= migration_class_name %>
  def change
    create_table :roles do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description, null: false, index: { unique: true }

      t.timestamps                null: false
    end
  end
end