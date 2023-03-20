require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
  let(:admin) { create(:user, admin: true) }
  let(:resource_category) { create(:resource_category) }

  before do
    sign_in admin
  end

  describe "GET #index" do
    it "assigns all resource categories as @resource_categories" do
      get :index
      expect(assigns(:resource_categories)).to eq([resource_category])
    end
  end

  describe "GET #show" do
    it "assigns the requested resource category as @resource_category" do
      get :show, params: { id: resource_category.to_param }
      expect(assigns(:resource_category)).to eq(resource_category)
    end
  end

  describe "GET #new" do
    it "assigns a new resource category as @resource_category" do
      get :new
      expect(assigns(:resource_category)).to be_a_new(ResourceCategory)
    end
  end
  describe "POST #create" do
    context "with valid params" do
      it "creates a new ResourceCategory" do
        expect {
          post :create, params: { resource_category: attributes_for(:resource_category) }
        }.to change(ResourceCategory, :count).by(1)
      end

      it "assigns a newly created resource category as @resource_category" do
        post :create, params: { resource_category: attributes_for(:resource_category) }
        expect(assigns(:resource_category)).to be_a(ResourceCategory)
        expect(assigns(:resource_category)).to be_persisted
      end

      it "redirects to the created resource category" do
        post :create, params: { resource_category: attributes_for(:resource_category) }
        expect(response).to redirect_to(ResourceCategory.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved resource category as @resource_category" do
        post :create, params: { resource_category: attributes_for(:resource_category, name: nil) }
        expect(assigns(:resource_category)).to be_a_new(ResourceCategory)
      end

      it "re-renders the 'new' template" do
        post :create, params: { resource_category: attributes_for(:resource_category, name: nil) }
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested resource category as @resource_category" do
      get :edit, params: { id: resource_category.to_param }
      expect(assigns(:resource_category)).to eq(resource_category)
    end
  end

  describe "PUT #update" do
    context "with invalid params" do
      it "assigns the resource category as @resource_category" do
        put :update, params: { id: resource_category.to_param, resource_category: attributes_for(:resource_category, name: nil) }
        expect(assigns(:resource_category)).to eq(resource_category)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { id: resource_category.to_param, resource_category: attributes_for(:resource_category, name: nil) }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested resource category" do
      expect {
        delete :destroy, params: { id: resource_category.to_param }
      }.to change(ResourceCategory, :count).by(-1)
    end

    it "redirects to the resource categories list" do
      delete :destroy, params: { id: resource_category.to_param }
      expect(response).to redirect_to(resource_categories_url)
    end
  end

  describe "POST #activate" do
    context "when successful activation" do
      before do 
        allow_any_instance_of(ResourceCategory).to receive(:activate).and_return(true)
      end

      it 'redirects to @resource_category' do 
        post :activate , params:{id:resource_category.to_param}
        expect(response).to redirect_to(resource_category)
      end

      it 'sets a flash notice' do 
        post :activate , params:{id:resource_category.to_param}
        expect(flash[:notice]).to eq('Category activated.')
      end
    end

    context "when unsuccessful activation" do 
      before do 
        allow_any_instance_of(ResourceCategory).to receive(:activate).and_return(false)
      end

      it 'redirects to @resource_category' do 
        post :activate , params:{id:resource_category.to_param}
        expect(response).to redirect_to(resource_category)
      end

      it 'sets a flash alert' do 
        post :activate , params:{id:resource_category.to_param}
        expect(flash[:alert]).to eq('There was a problem activating the category.')
      end
    end
  end

  describe "POST #deactivate" do
    context "when successful deactivation" do
      before do 
        allow_any_instance_of(ResourceCategory).to receive(:deactivate).and_return(true)
      end

      it 'redirects to @resource_category' do 
        post :deactivate , params:{id:resource_category.to_param}
        expect(response).to redirect_to(resource_category)
      end

      it 'sets a flash notice' do 
        post :deactivate , params:{id:resource_category.to_param}
        expect(flash[:notice]).to eq('Category deactivated.')
      end
    end

    context "when unsuccessful deactivation" do 
      before do 
        allow_any_instance_of(ResourceCategory).to receive(:deactivate).and_return(false)
      end

      it 'redirects to @resource_category' do 
        post :deactivate , params:{id:resource_category.to_param}
        expect(response).to redirect_to(resource_category)
      end

      it 'sets a flash alert' do 
        post :deactivate , params:{id:resource_category.to_param}
        expect(flash[:alert]).to eq('There was a problem deactivating the category.')
      end
    end
  end
end