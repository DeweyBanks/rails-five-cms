require 'rails_helper'

RSpec.describe Commander, type: :model do
  it { should belong_to(:commander_type) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  context "When commander_type is physician" do
    it "is included in physicians_scope" do
      commander_type = CommanderType.find_by(name: 'Physician')
      commander = FactoryBot.create(:commander, commander_type_id: commander_type.id)
      expect(Commander.physicians_scope).to include(commander)
    end
  end

  context "When commander_type is coach" do
    it "is included in coaches scope" do
      commander_type = CommanderType.find_by(name: 'Coach')
      commander = FactoryBot.create(:commander, commander_type_id: commander_type.id)
      expect(Commander.coaches_scope).to include(commander)
    end
  end
end
