class AddDeletedAtToScreenings < ActiveRecord::Migration[7.0]
  def change
    add_column :screenings, :deleted_at, :datetime
    add_index :screenings, :deleted_at
  end
end
