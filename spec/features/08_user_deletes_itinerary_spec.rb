require 'rails_helper'

feature 'user deletes itinerary', %q(
  As a user
  I want to delete an itinerary
  So that I can delete any canceled plan

  Acceptance Criteria:
  * I must be able to delete an itinerary from the itinerary edit page
  * I must be able to delete an itinerary from the itinerary details page
  * All hotel bookings and flight bookings associated with itinerary must be deleted
) do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:thailand) { Itinerary.create(user_id: user.id, name: "Thailand", destination_city: "Bangkok, Thailand", start_date: "2017-03-25", end_date: "2017-04-01") }

  scenario 'user deletes the itinerary from its edit page' do
    sign_in user

    visit edit_itinerary_path(thailand)

    expect(page).to have_link('Delete')
  end

  scenario 'user deletes the itinerary from its details page' do
    sign_in user

    visit itinerary_path(thailand)

    expect(page).to have_link('Delete')
  end

  scenario 'user deletes the itinerary successfully' do
    sign_in user

    visit edit_itinerary_path(thailand)
    click_link 'Delete'

    expect(page).to have_content('The itinerary was deleted')
  end

  scenario 'user attempts to delete itinerary created by another user' do
    sign_in user2

    visit edit_itinerary_path(thailand)
    click_link 'Delete'

    expect(page).to have_content('404')
  end

  scenario 'unauthorized user attempts to delete the itinerary' do
    visit root_path

    expect{visit edit_itinerary_path(thailand)}.to raise_error(ActionController::RoutingError)
  end
end
