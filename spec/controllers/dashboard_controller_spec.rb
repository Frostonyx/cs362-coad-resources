require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET #index' do
    context 'when user is not authenticated' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns @status_options' do
        get :index
        expect(assigns(:status_options)).not_to be_nil
      end

      it 'assigns @pagy' do
        get :index
        expect(assigns(:pagy)).not_to be_nil
      end

      it 'assigns @tickets' do
        get :index
        expect(assigns(:tickets)).not_to be_nil
      end
    end
  end
end