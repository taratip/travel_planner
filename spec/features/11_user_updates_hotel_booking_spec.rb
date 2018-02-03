require 'rails_helper'

feature 'user updates hotel booking', %q(
  As a user
  I want to edit hotel booking
  So that I can correct any mistakes or add updates

  Acceptance Criteria:
  * I must provide valid information for hotel booking
  * I must be presented with errors if I fill out the form incorrectly
  * I must be able to get to the edit page from the hotel booking's details page
) do
  let!(:user) { FactoryBot.create(:user) }
  let!(:thailand) { FactoryBot.create(:itinerary, user: user, destination_city: "Bangkok", start_date: "2017-03-25", end_date: "2017-04-01") }
  let!(:hotel_booking1) { FactoryBot.create(:hotel_booking, itinerary: thailand, arrival_date: "2017-04-01", arrival_time: "2:00pm", departure_date: "2017-04-03", departure_time: "10:00am")}

  scenario "user gets to hotel booking's details from itinerary details" do
    sign_in user

    visit itinerary_path(thailand)

    expect(page).to have_content("Edit")
  end

  scenario "user provides valid information to update successfully" do
    sign_in user

    visit edit_itinerary_hotel_booking_path(thailand, hotel_booking1)

    fill_in "Location name", with: "Wow Hills Guest House"
    fill_in "Address", with: "35, Wausan-ro 24-Gil, Mapo-gu,Seoul, 121-880"
    click_on "Save"

    expect(page).to have_content("Lodging was successfully updated.")
  end

  scenario "user is presented with errors when providing invalid information" do
    sign_in user

    visit edit_itinerary_hotel_booking_path(thailand, hotel_booking1)

    fill_in "Location name", with: ""
    click_on "Save"

    expect(page).to have_content("Location name can't be blank")
  end

  scenario 'unauthorized user attempts to update a hotel booking' do
    visit root_path

    expect{visit edit_itinerary_hotel_booking_path(thailand, hotel_booking1)}.to raise_error(ActionController::RoutingError)
  end
end
