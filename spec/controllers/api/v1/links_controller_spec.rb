require 'rails_helper'

RSpec.describe Api::V1::LinksController, type: :controller do
  # scenario "links#index" do
  #   user = User.create(email: "me@me.com", password: "password")
  #   link1  = Link.create(title: "link 1", url: "www.turing.io", read: 0, user_id: user.id)
  #   link2  = Link.create(title: "link 2", url: "www.google.com", read: 0, user_id: user.id)
  #   expect(Link.count).to eq(2)
  #
  #   get :index
  #
  #   links = JSON.parse(response.body)
  #
  #   expect(links.count).to eq(2)
  # end
  #
  # scenario "link#create" do
  #   user = User.create(email: "me@me.com", password: "password")
  #   expect(Link.count).to eq(0)
  #   post :create, { link: {
  #                   title: "Link title",
  #                   url: "https://www.turing.io",
  #                   user_id: user.id
  #                 }}
  #
  #   link = JSON.parse(response.body)
  #
  #   expect(Link.count).to eq(1)
  #   expect(link["title"]).to eq("Link title")
  #   expect(link["url"]).to eq("https://www.turing.io")
  #
  # end

  # scenario "link#update_content" do
  #   user = User.create(email: "me@me.com", password: "password")
  #   link = Link.create(title: "link 1", url: "www.turing.io", read: 0, user_id: user.id)
  #
  #   patch :update, { id: link.id, link: {
  #                    title: "New Title",
  #                    url: "https://www.google.com",
  #                    user_id: user.id
  #                   }}
  #   new_content = JSON.parse(response.body)
  #
  #   expect(new_content["title"]).to eq("New Title")
  #   expect(new_content["url"]).to eq("https://www.google.com")
  #   expect(new_content["id"]).to eq(link.id)
  # end
  #
  # scenario "link#update_read_status" do
  #   user = User.create(email: "me@me.com", password: "password")
  #   link = Link.create(title: "link 1", url: "www.turing.io", read: 0, user_id: user.id)
  #   expect(link["read"]).to eq(0)
  #
  #   patch :update, { id: link.id, link: { read: "1" } }
  #
  #   new_content = JSON.parse(response.body)
  #   expect(new_content["id"]).to eq(link.id)
  #   expect(new_content["read"]).to eq("read")
  # end

end
