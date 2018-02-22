require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:category) }
  it { should belong_to(:campaign) }
  it { should have_many(:comments) }
  it { should have_many(:taggings) }
  it { should have_many(:tags) }
  it { should have_many(:pictures) }
end
