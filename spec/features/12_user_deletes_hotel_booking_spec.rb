require 'rails_helper'

feature 'user deletes hotel booking', %q(
  As a user
  I want to delete a hotel booking
  So that I can delete any canceled hotel booking

  Acceptance Criteria:
  * I must be able to delete a hotel booking from the hotel booking edit page
  * I must be able to delete a hotel booking from the hotel booking details page
  * I must be able to delete a hotel booking from the itinerary details page
) do

  let!(:user) { FactoryBot.create(:user) }
  let!(:thailand) { FactoryBot.create(:itinerary, user: user, destination_city: "Bangkok", start_date: "2017-03-25", end_date: "2017-04-01") }
  let!(:hotel_booking1) { FactoryBot.create(:hotel_booking, itinerary: thailand, arrival_date: "2017-04-01", arrival_time: "2:00pm", departure_date: "2017-04-03", departure_time: "10:00am")}

  scenario 'User can delete a hotel booking from the itinerary details page' do
    sign_in user

    visit itinerary_path(thailand)

    within(:css, 'div.trip-item-row') do
      expect(page).to have_link("Delete")
    end
  end

  scenario 'User can delete a hotel booking successfully' do
    sign_in user

    visit itinerary_hotel_booking_path(thailand, hotel_booking1)
    click_link("Delete")

    expect(page).to have_content("Lodging was deleted.")
  end

end
