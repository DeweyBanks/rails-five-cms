FactoryBot.define do
  factory :comment do
    first_name "Doctor"
    last_name  "Doe"
    email "ddoe@example.com"
    body "text comment"
    # Post or Comment
    commentable_type "Post"

    # id of commentable_type commented on
    commentable_id 1
  end
end


