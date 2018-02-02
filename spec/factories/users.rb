FactoryBot.define do
  factory :user do
    email ""
    password "MyString"
    password_confirmation "MyString"
    super_admin false
  end
end
