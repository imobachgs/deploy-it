class AddRailsFieldToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :ruby_version, :string, null: false, default: '2'
    add_column :projects, :adapter, :string, null: false, default: 'postgresql'
    add_column :projects, :database, :string, null: false, default: 'rails'
    add_column :projects, :username, :string, null: false, default: 'rails'
    add_column :projects, :password, :string, null: false, default: 'rails'
    add_column :projects, :secret, :string, null: false, default: ''
  end
end
