require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'validations' do
    let(:ticket) { build(:ticket) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:region_id) }
    it { should validate_presence_of(:resource_category_id) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:description).is_at_most(1020).on(:create) }
    it { should allow_value('123-456-7890').for(:phone) }
    it { should_not allow_value('123').for(:phone) }
  end

  describe 'scopes' do
    let!(:ticket1) { create(:ticket, closed: false, organization_id: nil) }
    let!(:ticket2) { create(:ticket, closed: true) }
    let!(:ticket3) { create(:ticket, closed: false, organization_id: 1) }

    describe '.open' do
      it 'returns open tickets' do
        expect(Ticket.open).to include(ticket1)
        expect(Ticket.open).not_to include(ticket2)
        expect(Ticket.open).not_to include(ticket3)
      end
    end

    describe '.closed' do
      it 'returns closed tickets' do
        expect(Ticket.closed).to include(ticket2)
        expect(Ticket.closed).not_to include(ticket1)
        expect(Ticket.closed).not_to include(ticket3)
      end
    end

    describe '.all_organization' do
      it 'returns all tickets with an organization' do
        expect(Ticket.all_organization).to include(ticket3)
        expect(Ticket.all_organization).not_to include(ticket1)
        expect(Ticket.all_organization).not_to include(ticket2)
      end
    end

    describe '.organization' do
      it 'returns tickets for a specific organization' do
        expect(Ticket.organization(1)).to include(ticket3)
        expect(Ticket.organization(1)).not_to include(ticket1)
        expect(Ticket.organization(1)).not_to include(ticket2)
      end
    end

    describe '.closed_organization' do
      it 'returns closed tickets for a specific organization' do
        expect(Ticket.closed_organization(1)).not_to include(ticket1)
        expect(Ticket.closed_organization(1)).to include(ticket2)
        expect(Ticket.closed_organization(1)).to include(ticket3)
      end
    end

    describe '.region' do
      it 'returns tickets for a specific region' do
        expect(Ticket.region(ticket1.region_id)).to include(ticket1)
        expect(Ticket.region(ticket1.region_id)).not_to include(ticket2)
        expect(Ticket.region(ticket1.region_id)).not_to include(ticket3)
      end
    end

    describe '.resource_category' do
      it 'returns tickets for a specific resource category' do
        expect(Ticket.resource_category(ticket1.resource_category_id)).to include(ticket1)
        expect(Ticket.resource_category(ticket1.resource_category_id)).not_to include(ticket2)
        expect(Ticket.resource_category(ticket1.resource_category_id)).not_to include(ticket3)
      end
    end
  end

  describe 'methods' do
    let!(:ticket1) { create(:ticket, closed: false, organization_id: nil) }
    let!(:ticket2) { create(:ticket, closed: true, organization_id: 1) }

    describe '#open?' do
      it 'returns true if the ticket is open' do
        expect(ticket1.open?).to be true
      end

      it 'returns false if the ticket is closed' do
        expect(ticket2.open?).to be false
      end
    end

    describe '#captured?' do
      it 'returns true if the ticket is captured by an organization' do
        expect(ticket2.captured?).to be true
      end

      it 'returns false if the ticket is not captured by an organization' do
        expect(ticket1.captured?).to be false
      end
    end
  end
end