require 'rails_helper'

RSpec.describe Organization, type: :model do
  subject(:organization) { build(:organization) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:primary_name) }
    it { should validate_presence_of(:secondary_name) }
    it { should validate_presence_of(:secondary_phone) }

    it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:description).is_at_most(1020).on(:create) }

    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:name).case_insensitive }

    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('not_an_email').for(:email) }
  end

  describe 'associations' do
    it { should have_many(:users) }
    it { should have_many(:tickets) }
    it { should have_and_belong_to_many(:resource_categories) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(approved: 0, submitted: 1, rejected: 2, locked: 3).with_prefix }
    it { should define_enum_for(:transportation).with_values(yes: 0, no: 1, maybe: 2).backed_by_column_of_type(:integer) }
  end

  describe 'methods' do
    describe '#approve' do
      it 'sets the organization status to approved' do
        organization.approve
        expect(organization.status).to eq('approved')
      end
    end

    describe '#reject' do
      it 'sets the organization status to rejected' do
        organization.reject
        expect(organization.status).to eq('rejected')
      end
    end

    describe '#set_default_status' do
      context 'when the organization is new' do
        let(:organization) { build(:organization, status: nil) }

        it 'sets the organization status to submitted' do
          organization.send(:set_default_status)
          expect(organization.status).to eq('submitted')
        end
      end

      context 'when the organization is not new' do
        let(:organization) { build(:organization, status: :approved) }

        it 'does not change the organization status' do
          organization.send(:set_default_status)
          expect(organization.status).to eq('approved')
        end
      end
    end

    describe '#to_s' do
      it 'returns the organization name' do
        expect(organization.to_s).to eq(organization.name)
      end
    end
  end
end
