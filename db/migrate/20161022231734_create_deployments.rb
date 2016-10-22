class CreateDeployments < ActiveRecord::Migration[5.0]
  def change
    create_table :deployments do |t|
      t.references :project, foreign_key: true
      t.references :status, null: false
      t.timestamps
    end
  end
end
