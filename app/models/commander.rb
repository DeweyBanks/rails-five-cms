class Commander < ApplicationRecord
  belongs_to :commander_type
  validates :title, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  def self.physicians_scope
    where(commander_type_id: CommanderType.find_by(name: 'Physician').id)
  end

  def self.coaches_scope
    where(commander_type_id: CommanderType.find_by(name: 'Coach').id)
  end
end



