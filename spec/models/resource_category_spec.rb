require 'rails_helper'


describe ResourceCategory, type: :model do
    it { should have_and_belong_to_many(:organizations) }
    it { should have_many(:tickets) }
  
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }

  describe ".unspecified" do
    it "finds or creates the 'Unspecified' resource category" do
      unspecified = ResourceCategory.unspecified
      expect(unspecified).to be_an_instance_of(ResourceCategory)
      expect(unspecified.name).to eq("Unspecified")
  
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
  describe "associations" do
    it { should have_and_belong_to_many(:organizations) }
    it { should have_many(:tickets) }
  end

  describe "scopes" do
    let!(:active_category1) { FactoryBot.create(:resource_category, active: true) }
    let!(:active_category2) { FactoryBot.create(:resource_category, active: true) }
    let!(:inactive_category) { FactoryBot.create(:resource_category, active: false) }

    it "returns active categories" do
      expect(ResourceCategory.active).to eq([active_category1, active_category2])
    end

    it "returns inactive categories" do
      expect(ResourceCategory.inactive).to eq([inactive_category])
    end
  end

  describe "member functions" do
    let(:resource_category) { FactoryBot.create(:resource_category, active: true) }

    it "returns the category name as a string" do
      expect(resource_category.to_s).to eq(resource_category.name)
    end

    it "returns true if the category is inactive" do
      resource_category.deactivate
      expect(resource_category.inactive?).to eq(true)
    end

    it "activates the category" do
      resource_category.deactivate
      resource_category.activate
      expect(resource_category.active).to eq(true)
    end

    it "deactivates the category" do
      resource_category.deactivate
      expect(resource_category.active).to eq(false)
    end
  end

  describe "static functions" do
    let!(:unspecified_category) { FactoryBot.create(:resource_category, name: "Unspecified") }
    let!(:category1) { FactoryBot.create(:resource_category, name: "Category 1") }
    let!(:category2) { FactoryBot.create(:resource_category, name: "Category 2") }

    it "returns the unspecified category" do
      expect(ResourceCategory.unspecified).to eq(unspecified_category)
    end
  end
end


  
  