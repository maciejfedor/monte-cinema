class AddDeletedAtToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :deleted_at, :datetime
    add_index :movies, :deleted_at
  end
end
