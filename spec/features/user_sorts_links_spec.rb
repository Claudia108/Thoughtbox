require 'rails_helper'

RSpec.feature "user sorts links", js: true do
  scenario "sorts alphabetically by title" do
    user = User.create(email: "me@me.com", password: "password")
    link1 = Link.create(title: "sweet link", url: "https://www.turing.io", user_id: user.id)
    link2 = Link.create(title: "Best Link", url: "https://www.google.com", user_id: user.id)
    link3 = Link.create(title: "Awesome Link", url: "https://www.texarch.com", user_id: user.id)

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

    expect(page).to have_content("Sort Links")
    find("#sortLinks").click
    wait_for_ajax

    within(".links") do
      # expect(page.first(:css, ".list-group-item")).to have_link(title, href: url)
      expect(page.first(:css, ".list-group-item")).to have_content(link3.title)
      expect(page.first(:css, ".list-group-item")).to have_content(link3.url)

      expect(page.second(:css, ".list-group-item")).to have_content(link1.title)
      expect(page.second(:css, ".list-group-item")).to have_content(link1.url)

      expect(page.last(:css, ".list-group-item")).to have_content(link2.title)
      expect(page.last(:css, ".list-group-item")).to have_content(link2.url)
    end
  end
end
