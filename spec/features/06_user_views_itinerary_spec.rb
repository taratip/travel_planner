require 'rails_helper'

feature 'user views itinerary', %q(
  As a user
  I want to view itinerary's details
  So that I can check if the itinerary is up to date

  Acceptance Criteria:
  * I must be able to get to this page from the itinerary index
  * I must see the itinerary's name, start date and end date
) do

  let!(:user) { User.create(username: "guest", email: "user@example.com", password: "password1") }
  let!(:thailand) { Itinerary.create(user_id: user.id, name: "Thailand", destination_city: "Bangkok, Thailand", start_date: "2017-03-25", end_date: "2017-04-01") }
  let!(:korea) { Itinerary.create(user_id: user.id, name: "Korea", destination_city: "Seoul, South Korea", start_date: "2017-04-25", end_date: "2017-05-02") }

  scenario 'user navigates from the itinerary index' do
    sign_in user

    visit root_path

    expect(page).to have_content("Thailand")
    expect(page).to have_content("Korea")
  end

  scenario "user sees the itinerary's name, desination city, start date and end date" do
    sign_in user

    visit itinerary_path(thailand)

    expect(page).to have_content("Thailand")
    expect(page).to have_content("Bangkok, Thailand")
    expect(page).to have_content("Mar 25, 2017")
    expect(page).to have_content("Apr 01, 2017")
  end

  scenario 'unauthorized user attempts to view itinerary' do
    visit root_path

    expect{visit itinerary_path(thailand)}.to raise_error(ActionController::RoutingError)
  end
end
