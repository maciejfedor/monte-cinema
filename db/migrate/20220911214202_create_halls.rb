class CreateHalls < ActiveRecord::Migration[7.0]
  def change
    create_table :halls do |t|
      t.integer :number      
      t.integer :capacity
      t.timestamps
    end
  end
end
