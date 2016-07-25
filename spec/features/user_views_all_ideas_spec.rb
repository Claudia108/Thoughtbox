require 'rails_helper'

RSpec.feature "user views all links" do
  scenario "user sees all links", js: true do
    user = User.create(email: "me@me.com", password: "password")

    link1 = Link.create(title: "Link 1", url: "https://www.turing.io", read: "unread")
    link2 = Link.create(title: "Link 2", url: "https://www.google.com", read: "unread")
    # link3 = create_list(:link, 3)

    visit '/'

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")

    expect(current_path).to eq("/links")
    wait_for_ajax

    expect(page).to have_content(link1.title)
    expect(page).to have_content(link1.url)
    expect(page).to have_content(link1.read)

    expect(page).to have_content(link2.title)
    expect(page).to have_content(link2.url)
    expect(page).to have_content(link2.read)

    # expect(page).to have_content(link3.title)
    # expect(page).to have_content(link3.url)
    # expect(page).to have_content(link3.read)

    expect(page).to have_selector('h3', count: 2)
    expect(page).to have_selector('h4', count: 2)
  end
end
