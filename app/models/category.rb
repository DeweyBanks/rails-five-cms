class Category < ApplicationRecord
  include Filterable
  has_many :posts, -> { order("title") }
  validates :name, presence: true
  has_one :featured_post, -> {where(featured: true)}, class_name: "Post"
  before_destroy :update_post

  private

    def update_post
      if self.name == "Uncategorized"
        throw(:abort)
      else
        self.posts.each do |post|
          post.category = Category.find_or_create_by(name: "Uncategorized")
          post.save
        end
      end
    end
end
