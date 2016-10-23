class CreateDeployments < ActiveRecord::Migration[5.0]
  def change
    create_table :deployments do |t|
      t.references :project, foreign_key: true
      t.integer :status_id, null: false
      t.text :configuration
      t.timestamps
    end
  end
end
