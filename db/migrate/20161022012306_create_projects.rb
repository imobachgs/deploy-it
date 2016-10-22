class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :repo_url
      t.text :desc
      t.integer :kind_id, null: false

      t.timestamps
    end
  end
end
