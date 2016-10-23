class AddPortAndPostgresPasswordToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :port, :integer, default: 80
    add_column :projects, :db_admin_password, :string, default: ''
  end
end
