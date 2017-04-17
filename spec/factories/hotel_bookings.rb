FactoryGirl.define do
  factory :hotel_booking do
    sequence(:location_name) { |n| "Hotel #{n}" }
    address "1 Street name, City"
    phone_number "123456789"
    
    itinerary
  end
end
