FactoryBot.define do
  factory :comment do
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    email Faker::Internet.email
    body Faker::HarryPotter.quote
    association :commentable_type, name: "Post"
    commentable_id 1
  end
end


