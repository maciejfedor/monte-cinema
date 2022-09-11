class CreateScreenings < ActiveRecord::Migration[7.0]
  def change
    create_table :screenings do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.belongs_to :movie
      t.belongs_to :hall
      t.timestamps
    end
  end
end
