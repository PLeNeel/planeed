class AddSeenToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :seen, :boolean
  end
end
