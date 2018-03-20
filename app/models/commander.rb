class Commander < ApplicationRecord
  paginates_per 10
  belongs_to :commander_type
  validates :title, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  default_scope { order('created_at DESC') }

  def self.physicians
    where(commander_type_id: CommanderType.find_by(name: 'Physician').id)
  end

  def self.coaches
    where(commander_type_id: CommanderType.find_by(name: 'Coach').id)
  end
end



