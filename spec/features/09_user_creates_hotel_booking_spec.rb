require 'rails_helper'

feature 'user adds hotel booking to the itinerary', %q(
  As a user
  I want to add a new hotel booking to the itinerary
  So that I can view it

  Acceptance Criteria:
  * I must see option to add a new hotel booking in itinerary'd details page
  * I must supply hotel's name, check-in date and check-out date
  * If I provide with incomplete information, I receive an error message
) do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:korea) { Itinerary.create(user_id: user.id, name: "South Korea", destination_city: "Seoul, Republic of Korea", start_date: "2017-03-25", end_date: "2017-04-01") }

  scenario 'user sees option to add a new hotel booking in itinerary details page' do
    sign_in user

    visit itinerary_path(korea)

    expect(page).to have_content("Add Lodging")
  end

  scenario 'user successfully adds a hotel booking to itinerary created by the user' do
    sign_in user

    visit new_itinerary_hotel_booking_path(korea)

    fill_in "Location name", with: "Wow Hills Guest House"
    fill_in "Address", with: "35, Wausan-ro 24-Gil, Mapo-gu,Seoul, 121-880"
    fill_in "Arrival date", with: "2017-03-25"
    fill_in "Arrival time", with: "2:00pm"
    fill_in "Departure date", with: "2017-03-26"
    fill_in "Departure time", with: "11:00am"
    fill_in "Confirmation number", with: "130314028353"
    click_button "Save"

    expect(page).to have_content("Lodging was successfully created.")
  end

  scenario 'user sees error messages when supplies incomplete information' do
    sign_in user

    visit new_itinerary_hotel_booking_path(korea)

    fill_in "Location name", with: "Wow Hills Guest House"
    fill_in "Arrival time", with: "25:00"
    fill_in "Departure time", with: "11:00am"
    fill_in "Confirmation number", with: "130314028353"
    click_button "Save"

    expect(page).to have_content("Arrival date can't be blank")
    expect(page).to have_content("Departure date can't be blank")
    expect(page).to have_content("Arrival time is not a valid time")
  end

  scenario 'user creates a hotel booking with departure date before arrival date' do
    sign_in user

    visit new_itinerary_hotel_booking_path(korea)

    fill_in "Location name", with: "Wow Hills Guest House"
    fill_in "Address", with: "35, Wausan-ro 24-Gil, Mapo-gu,Seoul, 121-880"
    fill_in "Arrival date", with: "2017-03-25"
    fill_in "Departure date", with: "2017-03-01"

    click_button 'Save'

    expect(page).to have_content("Departure date must be after 2017-03-25")
  end

  scenario 'unauthorized user attempts to add a hotel booking' do
    visit root_path

    expect{visit new_itinerary_hotel_booking_path(korea)}.to raise_error(ActionController::RoutingError)
  end

end
