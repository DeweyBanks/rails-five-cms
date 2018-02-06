require 'rails_helper'

RSpec.describe CommanderType, type: :model do
  it { should have_many(:commanders) }
  it { should validate_presence_of(:name) }
end
