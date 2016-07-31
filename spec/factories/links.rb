FactoryGirl.define do
  factory :link do
    sequence(:title) { |n| "Link #{n}" }
    sequence(:url) { |n| "https://funsite#{n}.com" }
    read false
    user_id 
  end
end
