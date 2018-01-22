class CommanderType < ApplicationRecord
  has_many :commanders

  validates :name, presence: true
end
