require 'rails_helper'

RSpec.describe Region, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "associations" do
    it { should have_many(:tickets) }
  end

  describe "methods" do
    describe "#to_s" do
      let(:region) { create(:region, name: "Test Region") }

      it "returns the region name as a string" do
        expect(region.to_s).to eq("Test Region")
      end
    end

    describe ".unspecified" do
      context "when the Unspecified region exists" do
        let!(:unspecified_region) { create(:region, name: "Unspecified") }

        it "returns the Unspecified region" do
          expect(Region.unspecified).to eq(unspecified_region)
        end
      end

      context "when the Unspecified region doesn't exist" do
        it "creates and returns a new Unspecified region" do
          unspecified_region = Region.unspecified
          expect(unspecified_region).to be_persisted
          expect(unspecified_region.name).to eq("Unspecified")
        end
      end
    end
  end
end
