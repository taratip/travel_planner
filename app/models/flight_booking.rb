class FlightBooking < ApplicationRecord
  belongs_to :itinerary

  validates_presence_of :confirmation_number
end
