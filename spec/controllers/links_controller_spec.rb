RSpec.describe LinksController, type: :controller do
  before do
    User.create(email: "me@me.com", password: "password")
    LinksController.any_instance.stub(:current_user).and_return(User.last)
    Link.create(title: "link 1", url: "www.turing.io", user_id: User.last.id)
  end

  context "links#index" do
    it "gets index" do
      link1 = Link.create(title: "link 1", url: "www.turing.io", user_id: User.last.id)
      link2 = Link.create(title: "link 2", url: "www.google.com", user_id: User.last.id)
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

  context "link#create" do
    it "creates a new link" do
      expect(Link.count).to eq(0)
      post :create, { link: {
                      title: "Link One",
                      url: "https://www.turing.io",
                      user_id: User.last.id
                      }}

      expect(Link.count).to eq(1)
      expect(response.content_type).to eq "text/html"
      expect(Link.last.title).to eq("Link One")
      expect(Link.last.url).to eq("https://www.turing.io")
    end
  end
end
