require 'rails_helper'

RSpec.feature "user sorts links", js: true do
  scenario "sorts alphabetically by title" do
    user = User.create(email: "me@me.com", password: "password")
    link1 = Link.create(title: "Best Link", url: "https://www.turing.io", user_id: user.id)
    link2 = Link.create(title: "Sweet Link", url: "https://www.google.com", user_id: user.id)
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

    titles = page.all(".everyLink")
    expect(titles[0]).to have_content(link3.title)
    expect(titles[0]).to have_content(link3.url)

    expect(titles[1]).to have_content(link1.title)
    expect(titles[1]).to have_content(link1.url)

    expect(titles[2]).to have_content(link2.title)
    expect(titles[2]).to have_content(link2.url)
  end
end
