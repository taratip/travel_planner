require 'rails_helper'

feature 'user signs in', %q(As an existing user
  I want to sign in
  So that I can create itineraries and view them

  Acceptance Criteria:
  * I must see option for sign in
  * I must provide correct information to sign in
  * If information provided is not valid, I receive an error message
  * When I sign in, I can see option to create an itineraries) do

 let!(:user) { User.create(username: "guest", email: "user@example.com", password: "password1") }

    scenario 'user sees option for sign in' do
      visit root_path

      expect(page).to have_content('Sign in')
    end

    scenario 'user successfully signs in using email address' do
      visit new_user_session_path

      fill_in 'Login', with: 'user@example.com'
      fill_in 'Password', with: 'password1'

      click_button 'Sign in'

      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content 'Itineraries'
      expect(page).to have_content 'Sign out'
    end

    scenario 'user successfully signs in using username' do
      visit new_user_session_path

      fill_in 'Login', with: 'guest'
      fill_in 'Password', with: 'password1'

      click_button 'Sign in'

      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content 'Itineraries'
      expect(page).to have_content 'Sign out'
    end

    scenario 'user signs in providing invalid information' do
      visit new_user_session_path

      fill_in 'Login', with: 'guest1'
      fill_in 'Password', with: 'password1'

      click_button 'Sign in'

      expect(page).to have_content 'Invalid Login or password.'
    end
end
