require 'faker'

FactoryBot.define do
  factory :campaign do
    name Faker::Fallout.location
  end
end
