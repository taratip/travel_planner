require 'rails_helper'

feature 'user updates profile', %q(
  As an existing user
  I want to update my information
  So that I can keep my profile up to duplicate

  Acceptance Criteria:
  * I see option to update profile
  * I must specify valid information when updating
  * If I provide invalid information, I receive error messages
) do

 let!(:user) { User.create(username: "guest", email: "user@example.com", password: "password1") }

  scenario 'signed in user updates profile successfully' do
    sign_in user

    visit edit_user_registration_path

    fill_in "Username", with: "guest1"
    fill_in "Email", with: "user@example.com"
    fill_in "Current password", with: "password1"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
  end

  scenario 'signed in user updates profile with invalid information' do
    sign_in user

    visit edit_user_registration_path

    fill_in "Username", with: ''
    fill_in "Current password", with: "password1"
    click_button "Update"

    expect(page).to have_content("Username can't be blank")
  end
end
