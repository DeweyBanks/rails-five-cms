FactoryBot.define do
  factory :user do
    email "admin@ehe.com"
    password "MyString"
    password_confirmation "MyString"
    super_admin false
  end
end
