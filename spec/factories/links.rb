FactoryGirl.define do
  factory :link do
    sequence(:title) { |n| "Idea #{n}" }
    sequence(:body) { |n| "Description #{n}" }
    quality 0
    user_id 
  end
end
