class Category < ApplicationRecord
  has_many :posts, -> { order("title") }, dependent: :destroy
  validates :name, presence: true
end
