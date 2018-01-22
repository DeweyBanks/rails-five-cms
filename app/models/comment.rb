class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, :dependent => :destroy

  def full_name
    self.first_name + " " + self.last_name
  end
end
