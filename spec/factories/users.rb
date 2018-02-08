FactoryBot.define do
  factory :user do
    initialize_with { User.find_or_create_by(email: email) }
    email Faker::Internet.email
    password "MyString"
    password_confirmation "MyString"
    super_admin false
  end
end
