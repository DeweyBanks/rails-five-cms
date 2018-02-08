require 'faker'
FactoryBot.define do
  factory :post do
    slug Faker::Internet.slug
    title  Faker::Book.title
    body  Faker::BackToTheFuture.quote
    all_tags "test"
    category_id Category.first.id
    campaign_id Campaign.first.id
  end
end
