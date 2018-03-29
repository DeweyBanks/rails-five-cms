class Keyword < ApplicationRecord
  has_many :keywordings, :dependent => :delete_all
  has_many :posts, through: :keywordings
end
