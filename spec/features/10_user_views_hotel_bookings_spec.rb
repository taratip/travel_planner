require 'rails_helper'

feature 'user views hotel bookings in itinerary', %q(
  As a user
  I want to view itinerary's details including hotel bookings
  So that I can check if the itinerary is up to date

  Acceptance Criteria:
  * I must be able to get to this page from the itinerary index
  * I must see the hotel booking overview
  * I must be able to get to the hotel booking details from the itinerary details page
) do

  let!(:user) { FactoryBot.create(:user) }
  let!(:thailand) { FactoryBot.create(:itinerary, user: user, destination_city: "Bangkok", start_date: "2017-03-25", end_date: "2017-04-01") }
  let!(:hotel_booking1) { FactoryBot.create(:hotel_booking, itinerary: thailand, arrival_date: "2017-04-01", arrival_time: "2:00pm", departure_date: "2017-04-03", departure_time: "10:00am")}
  let!(:hotel_booking2) { FactoryBot.create(:hotel_booking, itinerary: thailand, arrival_date: "2017-04-04", arrival_time: "2:00pm", departure_date: "2017-04-05", departure_time: "10:00am")}

  scenario "user can see hotel booking's lists on itinerary details" do
    sign_in user

    visit itinerary_path(thailand)

    expect(page).to have_content("Hotel 1")
    expect(page).to have_content("Apr 01")
    expect(page).to have_content("2:00PM")
    expect(page).to have_content("Apr 03")
    expect(page).to have_content("10:00AM")

    expect(page).to have_content("Hotel 2")
    expect(page).to have_content("Apr 04")
    expect(page).to have_content("2:00PM")
    expect(page).to have_content("Apr 05")
    expect(page).to have_content("10:00AM")
  end

  scenario "user gets to hotel booking's details from itinerary details" do
    sign_in user

    visit itinerary_path(thailand)

    expect(page).to have_content(hotel_booking1.location_name)
    expect(page).to have_content("1 Street name, City")
    expect(page).to have_content("123456789")
    expect(page).to have_content("April 01, 2017")
    expect(page).to have_content("2:00PM")
    expect(page).to have_content("April 03, 2017")
    expect(page).to have_content("10:00AM")
  end

  scenario "user gets to hotel booking's details from itinerary details in order by date and time" do
    sign_in user

    visit itinerary_path(thailand)

    arrival_date_index = page.body.index("Apr 01")
    departure_date_index = page.body.index("Apr 03")

    expect(arrival_date_index).to be < departure_date_index
  end

  scenario 'unauthorized user attempts to view hotel bookings from itinerary details' do
    visit root_path

    expect{visit itinerary_path(thailand)}.to raise_error(ActionController::RoutingError)
  end
end
