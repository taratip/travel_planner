require 'rails_helper'

feature 'user updates itinerary', %q(
  As a user
  I want to edit an itinerary
  So that I can correct any mistakes or add updates

  Acceptance Criteria:
  * I must provide valid information
  * I must be presented with errors if I fill out the form incorrectly
  * I must be able to get to the edit page from the itinerary details page
) do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }

  let!(:thailand) { Itinerary.create(user_id: user.id, name: "Thailand", start_date: "2017-03-25", end_date: "2017-04-01") }

  scenario 'user edits the itinerary from the details page' do
    sign_in user

    visit itinerary_path(thailand)

    expect(page).to have_link("Edit")
  end

  scenario 'user updates the itinerary with valid information' do
    sign_in user

    visit edit_itinerary_path(thailand)

    fill_in "Name", with: "Thailand - Bangkok"
    fill_in "Start date", with: "2017-03-25"
    fill_in "End date", with: "2017-04-01"

    click_on "Save"

    expect(page).to have_content("Itinerary was successfully updated")
  end

  scenario 'user updates the itinerary with invalid information and is presented with errors' do
    sign_in user

    visit edit_itinerary_path(thailand)

    fill_in "Name", with: ""
    fill_in "Start date", with: ""
    fill_in "End date", with: ""

    click_on "Save"

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Start date can't be blank")
    expect(page).to have_content("End date can't be blank")
  end

  scenario 'user attemps to update an itinerary that is not his own' do
    sign_in user2

    visit edit_itinerary_path(thailand)

    fill_in "Name", with: "Thailand - Bangkok"
    fill_in "Start date", with: "2017-03-25"
    fill_in "End date", with: "2017-04-01"

    click_on "Save"

    expect(page).to have_content("404")
  end

  scenario 'unauthorized user attempts to edit the itinerary' do
    visit root_path

    expect{visit edit_itinerary_path(thailand)}.to raise_error(ActionController::RoutingError)
  end
end
