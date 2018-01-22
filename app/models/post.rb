class Post < ApplicationRecord
  belongs_to :campaign
  belongs_to :category
  has_many :comments, as: :commentable, :dependent => :destroy
end
