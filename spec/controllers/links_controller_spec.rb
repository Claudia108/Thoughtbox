RSpec.describe LinksController, type: :controller do
  before do
    @user = User.create(email: "me@me.com", password: "password")
    LinksController.any_instance.stub(:current_user).and_return(@user)
  end

  describe "links#index" do
    it "gets index" do
      link1 = Link.create(title: "link 1", url: "www.turing.io", user_id: @user.id)
      link2 = Link.create(title: "link 2", url: "www.google.com", user_id: @user.id)
      links = link1, link2

      get :index

      expect(response.status).to eq(200)
      expect(links.count).to eq(2)
    end

    it "it renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "link#create" do
    it "creates a new link" do
      expect(Link.count).to eq(0)
      post :create, { link: {
        title: "Link One",
        url: "https://www.turing.io",
        user_id: @user.id
        }}

      expect(Link.count).to eq(1)
      expect(response.content_type).to eq "text/html"
      expect(Link.last.title).to eq("Link One")
      expect(Link.last.url).to eq("https://www.turing.io")
    end
  end


  # describe "link#update_content" do
  #   @user = User.create(email: "me@me.com", password: "password")
  #   link = Link.create(title: "link 1", url: "www.turing.io", read: 0, @user_id: user.id)
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
  # describe "link#update_read_status" do
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
  #
  # describe "idea#update_content" do
  #   idea = create(:idea)
  #
  #   patch :update, { id: idea.id, idea: {
  #                    title: "New Title",
  #                    body: "New Description"
  #                   }}
  #   new_content = JSON.parse(response.body)
  #
  #   expect(new_content["title"]).to eq("New Title")
  #   expect(new_content["body"]).to eq("New Description")
  #   expect(new_content["id"]).to eq(idea.id)
  # end
  #
  # scenario "idea#update_quality" do
  #   idea = create(:idea)
  #
  #   patch :update, { id: idea.id, idea: { quality: 1 } }
  #
  #   new_content = JSON.parse(response.body)
  #   expect(new_content["id"]).to eq(idea.id)
  #   expect(new_content["quality"]).to eq("plausible")
  # end
  #
  # scenario "idea#delete" do
  #   idea = create(:idea)
  #
  #   expect(Idea.count).to eq(1)
  #
  #   delete :destroy, { id: idea.id }
  #
  #   id = response.body
  #
  #   expect(Idea.count).to eq(0)
  #   expect(id).to eq(idea.id.to_s)
  # end
