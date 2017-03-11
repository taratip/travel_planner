class Itinerary < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :start_date, :end_date, :destination_city
  validates_date :end_date, :after => :start_date
end