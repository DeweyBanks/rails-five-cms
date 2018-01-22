class Commander < ApplicationRecord
  belongs_to :commander_type

  def self.physicians_scope
    where(commander_type_id: CommanderType.find_by(name: 'Physician').id)
  end

  def self.coaches_scope
    where(commander_type_id: CommanderType.find_by(name: 'Coach').id)
  end
end
