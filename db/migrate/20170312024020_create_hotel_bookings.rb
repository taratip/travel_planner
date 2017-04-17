class CreateHotelBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :hotel_bookings do |t|
      t.belongs_to :itinerary,    null: false
      t.string :location_name,    null: false, default: ""
      t.string :address
      t.string :phone_number
      t.datetime :arrival_date,     null: false
      t.time :arrival_time
      t.datetime :departure_date,   null: false
      t.time :departure_time
      t.string :confirmation_number
      t.text :note

      t.timestamps null: false
    end
  end
end
