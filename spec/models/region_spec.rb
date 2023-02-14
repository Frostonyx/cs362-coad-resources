require 'rails_helper'

RSpec.describe Region, type: :model do

  it "exists" do
    Region.new
  end

  it "has a name" do
    region = Region.new
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = Region.new(name: name)
    result = region.to_s
  end

end

describe Region do
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(1).is_at_most(255) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should have_many(:tickets) }
end


RSpec.describe Region, type: :model do

  describe '#to_s' do
    it 'returns the name of the region' do
      region = Region.new(name: 'Test Region')
      expect(region.to_s).to eq 'Test Region'
    end
  end

  describe '.unspecified' do
    it 'finds or creates the region with name "Unspecified"' do
      unspecified_region = Region.unspecified
      expect(unspecified_region.name).to eq('Unspecified')
    end
  end
end

