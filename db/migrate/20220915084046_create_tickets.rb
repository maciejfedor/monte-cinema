class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :seat, null: false
      t.belongs_to :reservation
      t.timestamps
    end
  end
end
