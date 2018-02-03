require 'rails_helper'

feature 'user adds flight booking to the itinerary', %q(
  As a user
  I want to add a new flight booking to the itinerary
  So that I can view it

  Acceptance Criteria:
  * I must see option to add a new flight booking in itinerary'd details page
  * I must supply flight confirmation number
  * If I provide with incomplete information, I receive an error message
) do

  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:korea) { Itinerary.create(user_id: user.id, name: "South Korea", destination_city: "Seoul, Republic of Korea", start_date: "2017-03-25", end_date: "2017-04-01") }

  scenario 'user sees option to add a new flight booking in itinerary details page' do
    sign_in user

    visit itinerary_path(korea)

    expect(page).to have_content("Add Flight")
  end

  scenario 'user successfully adds a flight booking to itinerary created by the user' do
    sign_in user

    visit new_itinerary_flight_booking_path(korea)

    fill_in "Confirmation number", with: "CRMN1024"
    click_button "Save"

    expect(page).to have_content("Flight booking was successfully created.")
  end

  scenario 'user sees error messages when supplies incomplete information' do
    sign_in user

    visit new_itinerary_flight_booking_path(korea)
    
    fill_in "Confirmation number", with: ""
    click_button "Save"

    expect(page).to have_content("Confirmation number can't be blank")
  end
end
