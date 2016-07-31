require 'rails_helper'

RSpec.feature "user creates new link" do
  scenario "user fills in title and url and saves" do
    user = User.create(email: "me@me.com", password: "password")

    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")
    expect(current_path).to eq("/links")

    fill_in "Title", with: "Link 1"
    fill_in "Url", with: "http://www.turing.io"
    click_button("Save Link")

    expect(current_path).to eq("/links")

    expect(page).to have_content("My Links")

    expect(page).to have_content("Link 1")
    expect(page).to have_content("http://www.turing.io")
    expect(page).to have_content("Mark as Read")
  end
end
