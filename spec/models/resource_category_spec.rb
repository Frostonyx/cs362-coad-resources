require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

end

RSpec.describe ResourceCategory, type: :model do
    it { should have_and_belong_to_many(:organizations) }
    it { should have_many(:tickets) }
  
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }

end

describe ".unspecified" do
    it "finds or creates the 'Unspecified' resource category" do
      unspecified = ResourceCategory.unspecified
      expect(unspecified).to be_an_instance_of(ResourceCategory)
      expect(unspecified.name).to eq("Unspecified")
  
      # Ensure that if the 'Unspecified' resource category already exists, it is returned instead of creating a new one.
      expect(ResourceCategory.unspecified).to eq(unspecified)
    end
  end
  
  describe '#activate' do
    it 'activates a resource category' do
      resource_category = ResourceCategory.create(name: 'Test')
      resource_category.update(active: false)
      expect(resource_category.active).to eq false
      resource_category.activate
      expect(resource_category.active).to eq true
    end
  end

  describe '#deactivate' do
    it 'should change the active status to false' do
      resource_category = ResourceCategory.create(name: 'Test Category')
      expect(resource_category.active).to be true
      resource_category.deactivate
      expect(resource_category.reload.active).to be false
    end
  end
  
  