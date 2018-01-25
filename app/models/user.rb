class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    if self.first_name.present? && self.last_name.present?
      self.first_name + " " + self.last_name
    else
      self.email
    end
  end

end
