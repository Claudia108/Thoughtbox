require 'rails_helper'

RSpec.feature "user changes read_status of links", js: true do
  scenario "marks links as read" do
    user = User.create(email: "me@me.com", password: "password")
    link = Link.create(title: "Best Link", url: "https://www.turing.io", user_id: user.id)

    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")

    expect(current_path).to eq("/links")

    expect(page).to have_content(link.title)
    expect(page).to have_content(link.url)
    expect(link.read_status).to eq("unread")
    expect(page).to have_content("Mark as read")

    find("#markLink").click
    wait_for_ajax

    expect(page).to have_content("Mark as unread")
    expect(link.read_status).to eq("read")
  end

  scenario "marks links as unread" do
    user = User.create(email: "me@me.com", password: "password")
    link = Link.create(title: "Best Link", url: "https://www.turing.io", user_id: user.id)
    link.update(read: true)

    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")

    expect(current_path).to eq("/links")

    expect(page).to have_content(link.title)
    expect(page).to have_content(link.url)
    expect(link.read_status).to eq("read")
    expect(page).to have_content("Mark as unread")

    find("#markLink").click
    wait_for_ajax

    expect(page).to have_content("Mark as read")
    expect(link.read_status).to eq("unread")
  end
end
