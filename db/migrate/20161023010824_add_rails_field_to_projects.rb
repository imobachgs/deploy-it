class AddRailsFieldToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :ruby_version, :string, null: false
    add_column :projects, :adapter, :string, null: false
    add_column :projects, :database, :string, null: false
    add_column :projects, :username, :string, null: false
    add_column :projects, :password, :string, null: false
    add_column :projects, :secret, :string, null: false
  end
end
