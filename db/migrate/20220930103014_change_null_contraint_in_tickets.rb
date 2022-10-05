class ChangeNullContraintInTickets < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tickets, :reservation_id, false
  end
end
