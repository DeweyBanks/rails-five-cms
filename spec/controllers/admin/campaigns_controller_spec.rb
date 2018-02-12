require 'rails_helper'

RSpec.describe Admin::CampaignsController, type: :controller do
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

    it "assigns all campaigns" do
      expect(assigns[:campaigns]).to eq(Campaign.all)
    end
  end

  describe "get #new" do
    before :each do
      admin = FactoryBot.create(:user)
      sign_in(admin)
    end
    it "assigns a new Campaign instance variable" do
      get :new
      expect(assigns(:campaign)).to be_a_new(Campaign)
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
      it "saves a new Campaign to the database" do
        expect {
          post :create, params: { 'campaign' => attributes_for(:campaign) }
        }.to change(Campaign, :count).by(1)
      end

      it "redirects to the Campaigns page" do
        post :create, params: { 'campaign' => attributes_for(:campaign) }
        expect(response).to redirect_to admin_campaigns_url
      end
    end

    context "without valid attributes" do
      before :each do
        admin = FactoryBot.create(:user)
        sign_in(admin)
      end
      it "does not save the new Campaign" do
        expect{
          post :create, params: { 'campaign' => attributes_for(:campaign, name: nil) }
        }.to_not change(Campaign,:count)
      end

      it "re-renders the new method" do
        post :create, params: { 'campaign' => attributes_for(:campaign, name: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe "post #update" do
    before :each do
      admin = FactoryBot.create(:user)
      sign_in(admin)
      @campaign = FactoryBot.create(:campaign, name: 'First test campaign')
      put :update, params: {'id' => @campaign.id, 'campaign' => { 'name' => 'new campaign' } }
      @campaign.reload
    end

    it { expect(response).to redirect_to(admin_campaigns_url) }
    it { expect(@campaign.name).to eql('new campaign') }
  end

  describe "post #destroy" do
    it "deletes the Campaign" do
      admin = FactoryBot.create(:user)
      sign_in(admin)
      campaign = FactoryBot.create(:campaign)
      expect{
        delete :destroy, params: {'id' => campaign.id}
      }.to change(Campaign, :count).by(-1)
    end
  end
end
