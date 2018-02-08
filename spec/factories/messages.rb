FactoryBot.define do
  factory :message do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    company_name Faker::Company.name
    email Faker::Internet.email
    interest Faker::Types.string
    comment Faker::Hipster.sentence(3)
  end
end
