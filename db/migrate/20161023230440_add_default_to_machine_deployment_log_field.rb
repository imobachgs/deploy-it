class AddDefaultToMachineDeploymentLogField < ActiveRecord::Migration[5.0]
  def change
    change_column_default :machine_deployments, :log, from: nil, to: ''
  end
end
