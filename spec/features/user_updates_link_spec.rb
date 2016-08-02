require 'rails_helper'

RSpec.feature "user updates existing link" do
  setup do
    @user = User.create(email: "me@me.com",
                        password: "password")

    @link = Link.create(title: "My Link",
                        url:"https://www.google.com",
                        user_id: @user.id)
  end
  
  scenario "user fills in title and url and updates" do
    visit root_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button("LOGIN")
    expect(current_path).to eq("/links")

    expect(page).to have_content("My Links")

    expect(page).to have_content("My Link")
    expect(page).to have_content("Mark as Read")
    expect(page).to have_link("Edit Link")

    click_link("Edit Link")

    expect(current_path).to eq("/links/#{@link.id}/edit")

    fill_in "Title", with: "Link 2"
    fill_in "Url", with: "http://www.turing.io"
    click_button("Update Link")

    expect(current_path).to eq("/links")

    expect(page).to have_content("My Links")

    expect(page).to have_content("Link 2")
    expect(page).to have_content("http://www.turing.io")
    expect(page).to have_content("Mark as Read")
  end

  scenario "user can't update link with invalid url" do
    visit root_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button("LOGIN")
    expect(current_path).to eq("/links")

    expect(page).to have_content("My Links")

    expect(page).to have_content("My Link")
    expect(page).to have_content("Mark as Read")
    expect(page).to have_link("Edit Link")

    click_link("Edit Link")

    expect(current_path).to eq("/links/#{@link.id}/edit")

    fill_in "Url", with: "my invalid link"
    click_button("Update Link")

    expect(current_path).to eq(edit_link_path(@link))
    expect(page).to have_content("Data is missing or invalid! Try again")
  end
end
