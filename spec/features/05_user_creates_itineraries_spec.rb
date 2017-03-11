require 'rails_helper'

feature 'user creates an itinerary', %q(
  As a user
  I want to create a new itinerary
  So that I can view it

  Acceptance Criteria:
  * I must see option to create a new itinerary
  * I must specify a unique name for an itinerary
  * If I supply a duplicate itinerary name or a blank name, I receive an error message
) do
  let!(:user) { User.create(username: "guest", email: "user@example.com", password: "password1") }

  scenario 'user sees option to create a new itinerary' do
    sign_in user

    visit root_path

    expect(page).to have_content("New itinerary")
  end

  scenario 'user creates an itinerary successfully' do
    sign_in user

    visit new_itinerary_path

    fill_in 'Name', with: 'Thailand'
    fill_in 'Destination city', with: 'Bangkok, Thailand'
    fill_in 'Start date', with: '2017-03-25'
    fill_in 'End date', with: '2017-04-25'

    click_button 'Save'

    expect(page).to have_content("Itinerary was successfully created.")
  end

  scenario 'user creates an itinerary with invalid information' do
    sign_in user

    visit new_itinerary_path

    fill_in 'Name', with: ''
    fill_in 'Destination city', with: ''
    fill_in 'Start date', with: ''
    fill_in 'End date', with: ''

    click_button 'Save'

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Destination city can't be blank")
    expect(page).to have_content("Start date can't be blank")
    expect(page).to have_content("End date can't be blank")
  end

  scenario 'user creates an itinerary with end date before start date' do
    sign_in user

    visit new_itinerary_path

    fill_in 'Name', with: 'Thailand'
    fill_in 'Destination city', with: 'Bangkok, Thailand'
    fill_in 'Start date', with: '2017-03-25'
    fill_in 'End date', with: '2017-03-10'

    click_button 'Save'

    expect(page).to have_content("End date must be after 2017-03-25")
  end

  scenario 'unauthorized user attempts to create an itinerary' do
    visit root_path

    expect{visit new_itinerary_path}.to raise_error(ActionController::RoutingError)
  end
end
