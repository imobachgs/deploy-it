class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.integer :project_id, null: false
      t.integer :machine_id, null: false
      t.integer :role_id, null: false

      t.timestamps
    end
  end
end
