require 'rails_helper'

RSpec.feature "user filters links", js: true do
  scenario "by search term" do
    user = User.create(email: "me@me.com", password: "password")
    link1 = Link.create(title: "First Link", url: "https://www.turing.io", user_id: user.id)
    link2 = Link.create(title: "Second Link", url: "https://www.google.com", user_id: user.id)
    link3 = Link.create(title: "Third Link", url: "https://www.texarch.com", user_id: user.id)

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

    expect(page).to have_content("Filter Links")
    find("#filterLinks").click
    find("#filterLinks").set('first')
    wait_for_ajax

    expect(page).to have_content(link1.title)
    expect(page).to have_content(link1.url)

    expect(page).to_not have_content(link2.title)
    expect(page).to_not have_content(link2.url)
    expect(page).to_not have_content(link3.title)
    expect(page).to_not have_content(link3.url)

    find("#filterLinks").set('google')
    wait_for_ajax

    expect(page).to_not have_content(link1.title)
    expect(page).to_not have_content(link1.url)

    expect(page).to have_content(link2.title)
    expect(page).to have_content(link2.url)

    expect(page).to_not have_content(link3.title)
    expect(page).to_not have_content(link3.url)

    find("#filterLinks").set("Link");
    wait_for_ajax

    expect(page).to have_content(link1.title)
    expect(page).to have_content(link1.url)
    expect(page).to have_content(link2.title)
    expect(page).to have_content(link2.url)
    expect(page).to have_content(link3.title)
    expect(page).to have_content(link3.url)
  end
end
