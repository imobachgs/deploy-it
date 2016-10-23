class AddNotNullToMachineDeploymentsLogField < ActiveRecord::Migration[5.0]
  def change
    change_column_null :machine_deployments, :log, false, ''
  end
end
