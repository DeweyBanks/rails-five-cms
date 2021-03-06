class Message < ApplicationRecord
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  def full_name
    self.first_name + " " + self.last_name
  end
end
