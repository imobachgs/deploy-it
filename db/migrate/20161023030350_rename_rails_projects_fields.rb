class RenameRailsProjectsFields < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :adapter, :database_adapter
    rename_column :projects, :database, :database_name
    rename_column :projects, :username, :database_username
    rename_column :projects, :password, :database_password
  end
end
