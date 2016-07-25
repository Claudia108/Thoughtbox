FactoryGirl.define do
  factory :user do
    email "me@me.com"
    password_digest "password"
    password_confirmation "password"
  end
end
