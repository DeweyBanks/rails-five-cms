require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }

  it "is responds to full_name method" do
    message = FactoryBot.create(:message, :first_name => "John", :last_name => "Smith")
    expect(message.full_name).to eql("John Smith")
  end
end
