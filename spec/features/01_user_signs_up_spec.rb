require 'rails_helper'

feature 'user can sign up', %q(
  As a new user
  I want to sign up
  So that I can make a new itinerary

  Acceptance Criteria:
  * I must see option for sign up
  * I must provide valid information to sign up
  * I must specify a unique email address and username to sign up
  * If email address or username has been used already, I receive an error message
) do
  scenario 'user visits the website' do
    visit root_path

    expect(page).to have_content('Sign up')
    expect(page).to have_content('Sign in')
  end

  scenario 'user signs up with valid information' do
    visit new_user_registration_path

    fill_in "Username", with: "guest"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"

    click_button "Sign up"

    expect(page).to have_content("Welcome to Travel Planner! You have signed up successfully.")
    expect(page).to have_content("Sign out")
  end

  scenario 'user signs up with duplicated information' do
    user = User.create(username: "guest", email: "user@example.com", password: "password1")

    visit new_user_registration_path

    fill_in "Username", with: "guest"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password1"
    fill_in "Password confirmation", with: "password1"

    click_button "Sign up"

    expect(page).to have_content("Email has already been taken")
  end

  scenario 'user signs up with invalid information' do
    visit new_user_registration_path

    fill_in "Username", with: "user@example.com"
    click_button "Sign up"

    expect(page).to have_content("Username is invalid")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario 'user attempts to sign in without signing up' do
    visit root_path
    
    expect{visit itineraries_path}.to raise_error(ActionController::RoutingError)
  end
end
