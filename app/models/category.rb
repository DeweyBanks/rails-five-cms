class Category < ApplicationRecord
  has_many :posts, -> { order("title") }, dependent: :destroy
  validates :name, presence: true
  has_one :featured_post, -> {where(featured: true)}, class_name: "Post"

end
