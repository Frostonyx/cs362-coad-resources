require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:organization) { create(:organization) }

  before { sign_in user }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @organizations' do
      get :index
      expect(assigns(:organizations)).not_to be_nil
    end
  end

  describe 'GET #new' do
    before { sign_in user }

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns @organization' do
      get :new
      expect(assigns(:organization)).not_to be_nil
    end
  end

  describe 'POST #create' do
    before { sign_in user }

    context 'with valid attributes' do
      it 'creates a new organization' do
        expect {
          post :create, params: { organization: attributes_for(:organization) }
        }.to change(Organization, :count).by(1)
      end

      it 'redirects to organization_application_submitted_path' do
        post :create, params: { organization: attributes_for(:organization) }
        expect(response).to redirect_to(organization_application_submitted_path)
      end

      it 'sends an email to admin' do
        post :create, params: { organization: attributes_for(:organization) }
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new organization' do
        expect {
          post :create, params: { organization: attributes_for(:organization, name: nil) }
        }.not_to change(Organization, :count)
      end

      it 'renders the new template' do
        post :create, params: { organization: attributes_for(:organization, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    before { sign_in user }

    it 'renders the edit template' do
      get :edit, params: { id: organization.id }
      expect(response).to render_template(:edit)
    end

    it 'assigns @organization' do
      get :edit, params: { id: organization.id }
      expect(assigns(:organization)).not_to be_nil
    end
  end

  describe 'PATCH #update' do
    before { sign_in user }

    context 'with valid attributes' do
      it 'updates the organization' do
        patch :update, params: { id: organization.id, organization: { name: 'New Name' } }
        expect(organization.reload.name).to eq('New Name')
      end

      it 'redirects to organization_path' do
        patch :update, params: { id: organization.id, organization: { name: 'New Name' } }
        expect(response).to redirect_to(organization_path(id: organization.id))
      end
    end

    context 'with invalid attributes' do
      it 'does not update the organization' do
        patch :update, params: { id: organization.id, organization: { name: nil } }
        expect(organization.reload.name).not_to be_nil
      end

      it 'renders the edit template' do
        patch :update, params: { id: organization.id, organization: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET #show' do
    before { sign_in user }

    it 'renders the show template' do
      get :show, params: { id: organization.id }
      expect(response).to render_template(:show)
    end

    it 'assigns @organization' do
      get :show, params: { id: organization.id }
      expect(assigns(:organization)).not_to be_nil
    end
  end