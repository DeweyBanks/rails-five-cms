require 'rails_helper'

RSpec.describe Admin::CommandersController, type: :controller do
  describe "get #index" do
    before :each do
      admin = FactoryBot.create(:user)
      sign_in(admin)
      get :index
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "assigns all commanders" do
      expect(assigns[:commanders]).to eq(Commander.all)
    end
  end

  describe "get #show" do
    before :each do
      admin = FactoryBot.create(:user)
      sign_in(admin)
      commander = FactoryBot.create(:commander)
      get :show, params: { id: commander.id }
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders show template" do
      expect(response).to render_template("show")
    end
  end

  describe "get #new" do
    before :each do
      admin = FactoryBot.create(:user)
      sign_in(admin)
    end
    it "assigns a new Commander instance variable" do
      get :new
      expect(assigns(:commander)).to be_a_new(Commander)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "post #create" do
    context "with valid attributes" do
      before :each do
        admin = FactoryBot.create(:user)
        sign_in(admin)
      end
      it "saves a new Commander to the database" do
        attrs = attributes_for(:commander, commander_type_id: CommanderType.find_by_name("Coach").id)
        expect {
          post :create, params: {'commander' => attrs}
        }.to change(Commander, :count).by(1)
      end

      it "redirects to the Commander show" do
        attrs = attributes_for(:commander, commander_type_id: CommanderType.find_by_name("Coach").id)
        post :create, params: {'commander' => attrs}
        expect(response).to redirect_to admin_commander_url(Commander.last)
      end
    end

    context "without valid attributes" do
      before :each do
        admin = FactoryBot.create(:user)
        sign_in(admin)
      end
      it "does not save the new Commander" do
        expect{
          post :create, params: { 'commander' => attributes_for(:commander, commander_type_id: nil) }
        }.to_not change(Commander,:count)
      end

      it "re-renders the new method" do
        post :create, params: { 'commander' => attributes_for(:commander, commander_type_id: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe "post #update" do
    before :each do
      admin = FactoryBot.create(:user)
      sign_in(admin)
      @commander = FactoryBot.create(:commander, title: 'Coach', commander_type_id: CommanderType.find_by_name("Coach").id)
      put :update, params: {'id' => @commander.id, 'commander' => { 'title' => 'new title' } }
      @commander.reload
    end

    it { expect(response).to redirect_to(admin_commander_url(@commander)) }
    it { expect(@commander.title).to eql('new title') }
  end

  describe "post #destroy" do
    it "deletes the Commander" do
      admin = FactoryBot.create(:user)
      sign_in(admin)
      commander = FactoryBot.create(:commander, commander_type_id: CommanderType.find_by_name("Coach").id)
      expect{
        delete :destroy, params: {'id' => commander.id}
      }.to change(Commander, :count).by(-1)
    end
  end
end
