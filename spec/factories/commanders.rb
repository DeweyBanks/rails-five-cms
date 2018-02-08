FactoryBot.define do
  factory :commander do
    title Faker::Name.title
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    association :commander_type, name: "Physician"
  end
end
