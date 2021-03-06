class CreateMachineDeployments < ActiveRecord::Migration[5.0]
  def change
    create_table :machine_deployments do |t|
      t.references :deployment, foreign_key: true
      t.references :machine, foreign_key: true
      t.references :status, null: false
      t.text :log
      t.text :roles

      t.timestamps
    end
  end
end
