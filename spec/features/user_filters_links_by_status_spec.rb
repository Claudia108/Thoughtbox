require 'rails_helper'

RSpec.feature "user filters links by status", js: true do
  scenario "filters unread links" do
    user = User.create(email: "me@me.com", password: "password")
    link1 = Link.create(title: "First Link",
                        url: "https://www.turing.io",
                        user_id: user.id, read: true)
    link2 = Link.create(title: "Second Link",
                        url: "https://www.google.com",
                        user_id: user.id, read: false)
    link3 = Link.create(title: "Third Link",
                        url: "https://www.texarch.com",
                        user_id: user.id, read: false)

    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")

    expect(current_path).to eq("/links")

    expect(page).to have_content(link1.title)
    expect(page).to have_content(link1.url)
    expect(page).to have_content(link2.title)
    expect(page).to have_content(link2.url)
    expect(page).to have_content(link3.title)
    expect(page).to have_content(link3.url)

    expect(page).to have_content("Unread Links")
    find("#unreadLinks").click
    wait_for_ajax

    expect(page).to not_have_content(link1.title)
    expect(page).to not_have_content(link1.url)

    expect(page).to have_content(link2.title)
    expect(page).to have_content(link2.url)
    expect(page).to have_content(link3.title)
    expect(page).to have_content(link3.url)
  end

  scenario "filters read links" do
    user = User.create(email: "me@me.com", password: "password")
    link1 = Link.create(title: "First Link",
                        url: "https://www.turing.io",
                        user_id: user.id, read: true)
    link2 = Link.create(title: "Second Link",
                        url: "https://www.google.com",
                        user_id: user.id, read: false)
    link3 = Link.create(title: "Third Link",
                        url: "https://www.texarch.com",
                        user_id: user.id, read: false)

    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")

    expect(current_path).to eq("/links")

    expect(page).to have_content(link1.title)
    expect(page).to have_content(link1.url)
    expect(page).to have_content(link2.title)
    expect(page).to have_content(link2.url)
    expect(page).to have_content(link3.title)
    expect(page).to have_content(link3.url)

    expect(page).to have_content("Read Links")
    find("#readLinks").click
    wait_for_ajax

    expect(page).to have_content(link1.title)
    expect(page).to have_content(link1.url)

    expect(page).to not_have_content(link2.title)
    expect(page).to not_have_content(link2.url)
    expect(page).to not_have_content(link3.title)
    expect(page).to not_have_content(link3.url)
  end

end
