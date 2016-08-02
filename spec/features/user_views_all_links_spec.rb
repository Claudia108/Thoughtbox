require 'rails_helper'

RSpec.feature "user views all links" do
  scenario "user sees all links" do
    user = User.create(email: "me@me.com", password: "password")

    link1 = Link.create(title: "Link 1", url: "https://www.turing.io",
                        user_id: user.id)
    link2 = Link.create(title: "Link 2", url: "https://www.google.com",
                        user_id: user.id)

    visit '/'

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button("LOGIN")

    expect(current_path).to eq("/links")

    expect(page).to have_content("My Links")

    expect(page).to have_content(link1.title)
    expect(page).to have_content(link1.url)

    expect(page).to have_content(link2.title)
    expect(page).to have_content(link2.url)

    within(".links") do
      expect(page).to have_selector('h3', count: 2)
      expect(page).to have_selector('h4', count: 2)
    end
  end
end
