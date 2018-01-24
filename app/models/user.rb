class User < ApplicationRecord
  before_validation :set_role, on: :create
  belongs_to :role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    if self.first_name.present? && self.last_name.present?
      self.first_name + " " + self.last_name
    else
      self.email
    end
  end

  def is_admin?
    self.role.name == "Admin" || self.role.name == "SuperAdmin"
  end

  def is_super_admin?
    self.role.name == "SuperAdmin"
  end

  private

    def set_role
      if self.role.present?
        self.role = self.role
      else
        self.role = Role.find_by(name: "User")
      end
    end

end
