require 'rails_helper'

feature 'user views/updates/deletes flight booking to the itinerary', %q(
  As a user
  I want to view a created flight booking to the itinerary
  I can update with correct information
  I can delete if it's no longer need

  Acceptance Criteria:
  * I must see a flight booking in itinerary'd details page
  * I must supply flight confirmation number
  * If I provide with incomplete information, I receive an error message
  * I must see option to update a flight booking with correct information
  * I must see option to delete it if I don't need it any more

) do

  let!(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:korea) { Itinerary.create(user_id: user.id, name: "South Korea", destination_city: "Seoul, Republic of Korea", start_date: "2017-03-25", end_date: "2017-04-01") }
  let!(:flight1) { FlightBooking.create(itinerary_id: korea.id, confirmation_number: 'CRMN1024') }

  scenario 'user sees a flight booking information in itinerary details page' do
    sign_in user

    visit itinerary_path(korea)

    expect(page).to have_content("CRMN1024")
  end

  scenario 'user sees option to edit or delete flight booking on itinerary detail created by the user' do
    sign_in user

    visit itinerary_path(korea,flight1)

    within(:css, 'div.trip-item-row:eq(1)') do
      expect(page).to have_content("Edit")
      expect(page).to have_content("Delete")
    end
  end

  scenario 'user updates flight confirmation number information' do
    sign_in user

    visit edit_itinerary_flight_booking_path(korea,flight1)

    fill_in "Confirmation number", with: "CRMN1022"
    click_button "Save"

    expect(page).to have_content("CRMN1022")
  end

  scenario 'user deletes the flight booking' do
    sign_in user

    visit itinerary_path(korea)

    within(:css, 'div.trip-item-row:eq(1)') do
      click_link 'Delete'
    end

    expect(page).to have_content('The flight booking was deleted')
  end

end
