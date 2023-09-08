class AllowMe < ActiveRecord::Migration<%= migration_class_name %>
  def change
    create_table :<%= tableized_model_class(role_class_name) %> do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description, null: false, index: { unique: true }

      t.timestamps                null: false
    end

    <% model_class_names.map { |u| tableized_model_class(u) }.each do |user_class_name| %><% if ActiveRecord::Base.connection.table_exists?(user_class_name) %>
    add_reference :<%= user_class_name %>, :<%= role_class_name.singularize.underscore %>, foreign_key: true, null: true
    <% else %>
    create_table :<%= user_class_name %> do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :<%= role_class_name.singularize.underscore %>_id, foreign_key: true, null: true

      t.timestamps                null: false
    end<% end %><% end %>
  end
end