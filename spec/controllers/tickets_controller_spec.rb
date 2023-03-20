require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:region) { create(:region) }
      let(:resource_category) { create(:resource_category) }
      let(:params) { { ticket: attributes_for(:ticket, region_id: region.id, resource_category_id: resource_category.id) } }

      it "creates a new ticket" do
        expect {
          post :create, params: params
        }.to change(Ticket, :count).by(1)
      end

      it "redirects to the ticket_submitted page" do
        post :create, params: params
        expect(response).to redirect_to(ticket_submitted_path)
      end
    end

    context "with invalid params" do
      let(:params) { { ticket: attributes_for(:ticket, name: nil) } }

      it "does not create a new ticket" do
        expect {
          post :create, params: params
        }.not_to change(Ticket, :count)
      end

      it "renders the new template" do
        post :create, params: params
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET show" do
    let(:ticket) { create(:ticket) }

    context "when the user is an admin" do
      before { sign_in create(:user, admin: true) }

      it "renders the show template" do
        get :show, params: { id: ticket.id }
        expect(response).to render_template(:show)
      end
    end

    context "when the user is an organization member" do
      before { sign_in create(:user, organization: ticket.organization) }

      it "renders the show template" do
        get :show, params: { id: ticket.id }
        expect(response).to render_template(:show)
      end
    end

    context "when the user is not an admin or an organization member" do
      before { sign_in create(:user) }

      it "redirects to the dashboard page" do
        get :show, params: { id: ticket.id }
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  describe "POST capture" do
    let(:ticket) { create(:ticket) }

    context "when the user is an organization member" do
      before { sign_in create(:user, organization: ticket.organization) }

      it "captures the ticket" do
        post :capture, params: { id: ticket.id }
        expect(TicketService).to have_received(:capture_ticket).with(ticket.id, kind_of(User))
      end

      it "redirects to the dashboard page with the open tickets tab selected" do
        post :capture, params: { id: ticket.id }
        expect(response).to redirect_to("#{dashboard_path}#tickets:open")
      end

      context "when there was a problem capturing the ticket" do
        before { allow(TicketService).to receive(:capture_ticket).and_return(:error) }

        it "renders the show template" do
          post :capture, params: { id: ticket.id }
          expect(response).to render_template(:show)
        end
      end
    end
end
end
