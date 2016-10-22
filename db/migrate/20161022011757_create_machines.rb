class CreateMachines < ActiveRecord::Migration[5.0]
  def change
    create_table :machines do |t|
      t.string :ip, null: false
      t.string :name

      t.timestamps
    end
  end
end
