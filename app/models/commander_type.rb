class CommanderType < ApplicationRecord
  has_many :commanders, dependent: :destroy

  validates :name, presence: true
end
