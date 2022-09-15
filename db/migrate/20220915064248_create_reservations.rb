class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :status, null: false
      t.belongs_to :screening
      t.timestamps
    end
  end
end
