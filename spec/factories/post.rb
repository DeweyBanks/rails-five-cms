require 'faker'
FactoryBot.define do
  factory :post do
    slug Faker::Internet.slug
    title  Faker::Book.title
    body  Faker::BackToTheFuture.quote
    all_tags "test"
    association :category, name: "News"
    association :campaign, name: "Helathy Living"
  end
end
