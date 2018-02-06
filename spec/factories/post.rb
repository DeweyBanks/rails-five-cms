FactoryBot.define do
  factory :post do
    slug "default test"
    title  "default test"
    body  "default test"
    all_tags "test"
    category_id 1
    campaign_id 1
  end
end
