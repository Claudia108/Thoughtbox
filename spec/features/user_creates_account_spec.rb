require 'rails_helper'

RSpec.feature "User creates account" do
  scenario "they create a new account" do
    visit root_path

    expect(page).to have_content("Welcome to Thoughtbox")
    expect(page).to have_link('SIGN UP')

    click_on("SIGN UP")

    expect(page).to have_current_path(new_user_path)

    fill_in "Email", with: "bob@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"

    click_on("Create Account")

    expect(page).to have_current_path('/links')
    within(".flash-notice") do
      expect(page).to have_content("Account Created! Logged in as bob@gmail.com")
    end
  end

  scenario "they can login when they have created an account" do
    user = User.create(email: "me@me.com", password: "password")

    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")

    within(".flash-notice") do
      expect(page).to have_content("Logged in as #{user.email}")
    end

    expect(page).to have_current_path('/links')
    expect(page).to have_content("My Links")

    expect(page).to have_link('Sign Out')
  end

  scenario "they can logout after logging in" do
    user = User.create(email: "me@me.com", password: "password")

    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")

    expect(page).to have_current_path('/links')
    expect(page).to have_content("My Thoughtbox")

    expect(page).to have_link('Sign Out')
    click_link("Sign Out")
    expect(page).to have_current_path('/login')

    within(".flash-notice") do
      expect(page).to have_content("Logged out!")
    end
  end
end
