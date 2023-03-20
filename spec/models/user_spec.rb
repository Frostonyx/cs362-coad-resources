require 'rails_helper'

RSpec.describe User, type: :model do

    describe "validations" do
      it { should validate_presence_of(:email) }
      it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
      it { should validate_uniqueness_of(:email).case_insensitive }
      it { should validate_confirmation_of(:email).with(VALID_EMAIL_REGEX) }
      it { should validate_presence_of(:password).on(:create) }
      it { should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create) }
    end

    describe "member functions" do
      let(:user) { FactoryBot.create(:user) }
  
      it "sets the default role to organization" do
        expect(user.role).to eq("organization")
      end
  
      it "returns the email address as a string" do
        expect(user.to_s).to eq(user.email)
      end
    end
  
    describe "static functions" do
      let!(:admin) { FactoryBot.create(:user, :admin) }
      let!(:organization_user) { FactoryBot.create(:user) }
  
      it "returns the admin users" do
        expect(User.admin).to eq([admin])
      end
    end
  
    describe "scope methods" do
      let!(:organization1) { FactoryBot.create(:organization) }
      let!(:organization2) { FactoryBot.create(:organization) }
      let!(:user1) { FactoryBot.create(:user, organization: organization1) }
      let!(:user2) { FactoryBot.create(:user, organization: organization1) }
      let!(:user3) { FactoryBot.create(:user, organization: organization2) }
  
      it "returns the users for a given organization" do
        expect(User.for_organization(organization1)).to eq([user1, user2])
      end
    end

end