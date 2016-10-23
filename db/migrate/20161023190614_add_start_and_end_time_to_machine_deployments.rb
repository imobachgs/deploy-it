class AddStartAndEndTimeToMachineDeployments < ActiveRecord::Migration[5.0]
  def change
    add_column :machine_deployments, :started_at, :datetime
    add_column :machine_deployments, :finished_at, :datetime
  end
end
