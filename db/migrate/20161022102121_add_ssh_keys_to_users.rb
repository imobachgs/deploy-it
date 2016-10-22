class AddSshKeysToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ssh_public_key, :text
    add_column :users, :ssh_private_key, :text
  end
end
