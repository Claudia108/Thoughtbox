require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
  end

  it "validates url" do
    link = Link.new(title: "My link", url: "My cool link")
    expect(link.valid?).to be false

    link = Link.new(title: "My link", url: "http://www.google.com")
    expect(link.valid?).to be true
  end

  it "has a false default value for read " do
    link = Link.new(title: "My Link", url: "enter url here")
    expect(link.read).to be false
  end

  context 'read_status' do
    it 'returns "read" when read is true' do
      link1 = Link.new(title: "My link", url: "https://turing.io")
      link2 = Link.new(title: "My link", url: "https://turing.io", read: true)

      expect(link1.read_status).to eq(nil)
      expect(link2.read_status).to eq("read")
    end
  end

  # context 'mark_as_status' do
  #   it 'returns "Mark as Read" when read is true' do
  #     link1 = Link.new(title: "My link", url: "https://turing.io")
  #     link2 = Link.new(title: "My link", url: "https://turing.io", read: true)
  #
  #     expect(link1.mark_as_status).to eq("Mark as Read")
  #     expect(link2.mark_as_status).to eq("Mark as Unread")
  #   end
  # end
end
