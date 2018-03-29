class Keywording < ApplicationRecord
  belongs_to :post
  belongs_to :keyword
end
