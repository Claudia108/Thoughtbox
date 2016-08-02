require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
  
  context "asssociations" do
    it { should have_many(:links) }
  end
end
