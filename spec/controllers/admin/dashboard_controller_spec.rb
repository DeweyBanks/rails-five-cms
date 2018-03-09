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

end
