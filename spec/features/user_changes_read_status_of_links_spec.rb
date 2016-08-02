require 'rails_helper'

RSpec.feature "user changes read_status of links", js: true do
  setup do
    @user = User.create(email: "me@me.com",
                       password: "password")
    @link = Link.create(title: "Best Link",
                       url: "https://www.turing.io",
                       user_id: @user.id)
  end

  scenario "marks links as read" do
    visit root_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button("LOGIN")

    expect(current_path).to eq("/links")

    expect(page).to have_content(@link.title)
    expect(page).to have_content(@link.url)
    expect(page).to have_content("Mark as Read")

    find(".markAsRead").click
    wait_for_ajax

    expect(page).to have_content("Mark as Unread")
  end

  scenario "marks links as unread" do
    @link.update(read: true)

    visit root_path

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button("LOGIN")

    expect(current_path).to eq("/links")

    expect(page).to have_content(@link.title)
    expect(page).to have_content(@link.url)
    expect(page).to have_content("Mark as Unread")

    find(".markAsUnread").click
    wait_for_ajax

    expect(page).to have_content("Mark as Read")
  end
end
