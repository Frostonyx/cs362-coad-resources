require 'rails_helper'

RSpec.describe Organization, type: :model do

end

RSpec.describe Organization, type: :model do
    it { should have_many(:users) }
    it { should have_many(:tickets) }
    it { should have_and_belong_to_many(:resource_categories) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:primary_name) }
    it { should validate_presence_of(:secondary_name) }
    it { should validate_presence_of(:secondary_phone) }
    it { should validate_length_of(:email).is_at_least(1).is_at_most(255) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255) }
    it { should validate_length_of(:description).is_at_most(1020) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should allow_value("email@example.com").for(:email) }
  end
  


  describe '#to_s' do
    let(:organization) { Organization.new(name: 'Organization Name') }
  
    it 'returns the name of the organization' do
      expect(organization.to_s).to eq('Organization Name')
    end
  end

  describe "#approve" do
    let(:organization) { Organization.new(email: "test@example.com", name: "Test Organization", phone: "555-555-5555", primary_name: "John Doe", secondary_name: "Jane Doe", secondary_phone: "555-555-5556") }
  
    it "changes the status to approved" do
      organization.approve
      expect(organization.status).to eq("approved")
    end
  end

  describe '#reject' do
    it 'should change the status of the organization to rejected' do
      organization = Organization.create(email: 'test@test.com', name: 'Test Organization', phone: '555-555-5555', status: :submitted, primary_name: 'John Doe', secondary_name: 'Jane Doe', secondary_phone: '555-555-5555')
      expect(organization.status).to eq 'submitted'
      organization.reject
      expect(organization.status).to eq 'rejected'
    end
  end

  describe '#set_default_status' do
    it 'sets the default status to :submitted' do
      organization = Organization.new
      organization.set_default_status
      expect(organization.status).to eq("submitted")
    end
  end
  