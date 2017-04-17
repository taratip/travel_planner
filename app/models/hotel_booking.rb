class HotelBooking < ApplicationRecord
  belongs_to :itinerary

  validates_presence_of :location_name, :arrival_date, :departure_date
  validates_date :departure_date, :after => :arrival_date
  validates_time :arrival_time, allow_nil: true
  validates_time :departure_date, allow_nil: true
end
