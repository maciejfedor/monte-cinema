class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.integer :status, null: false
      t.belongs_to :screening
      t.belongs_to :user
      t.timestamps
    end
  end
end
