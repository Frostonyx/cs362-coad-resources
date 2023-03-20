RSpec.describe RegionsController, type: :controller do
    let(:admin_user) { create(:user, :admin) }
    let(:region) { create(:region) }
  
    describe "GET #index" do
      context "when user is an admin" do
        before do
          sign_in admin_user
          get :index
        end
  
        it "returns a successful response" do
          expect(response).to be_successful
        end
  
        it "assigns all regions to @regions" do
          expect(assigns(:regions)).to eq([region])
        end
  
        it "renders the index template" do
          expect(response).to render_template(:index)
        end
      end
  
      context "when user is not an admin" do
        before do
          sign_in create(:user)
          get :index
        end
  
        it "redirects to the root path" do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  
    describe "GET #show" do
      context "when user is an admin" do
        before do
          sign_in admin_user
          get :show, params: { id: region.id }
        end
  
        it "returns a successful response" do
          expect(response).to be_successful
        end
  
        it "assigns the requested region to @region" do
          expect(assigns(:region)).to eq(region)
        end
  
        it "renders the show template" do
          expect(response).to render_template(:show)
        end
      end
  
      context "when user is not an admin" do
        before do
          sign_in create(:user)
          get :show, params: { id: region.id }
        end
  
        it "redirects to the root path" do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  
    describe "GET #new" do
      context "when user is an admin" do
        before do
          sign_in admin_user
          get :new
        end
  
        it "returns a successful response" do
          expect(response).to be_successful
        end
  
        it "assigns a new region to @region" do
          expect(assigns(:region)).to be_a_new(Region)
        end
  
        it "renders the new template" do
          expect(response).to render_template(:new)
        end
      end
  
      context "when user is not an admin" do
        before do
          sign_in create(:user)
          get :new
        end
  
        it "redirects to the root path" do
          expect(response).to redirect_to(root_path)
        end
      end
    end
  
    describe "POST #create" do
      context "when user is an admin" do
        before { sign_in admin_user }
  
        context "with valid parameters" do
          it "creates a new region" do
            expect {
              post :create, params: { region: attributes_for(:region) }
            }.to change(Region, :count).by(1)
          end
  
          it "redirects to the regions index page" do
            post :create, params: { region: attributes_for(:region) }
            expect(response).to redirect_to(regions_path)
          end
  
          it "sets a flash notice message" do
            post :create, params: { region: attributes_for(:region) }
            expect(flash[:notice]).to eq("Region successfully created.")
          end
        end
    end
end
end
  