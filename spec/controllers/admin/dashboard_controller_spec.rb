require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
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
  end

  describe "get #update_commanders" do
    before :each do
      @commanders = Commander.all
      admin = FactoryBot.create(:user)
      sign_in(admin)
      post :update_commanders
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "populates commanders" do
      expect(Commander.all.length).to be > @commanders.length
    end
  end
end
