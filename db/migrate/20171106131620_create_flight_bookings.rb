class CreateFlightBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :flight_bookings do |t|
      t.belongs_to :itinerary,        null: false
      t.string :confirmation_number,  null: false, default: ""

      t.timestamps null: false
    end
  end
end
