require 'rails_helper'

RSpec.describe "Admin/Campaigns" do

  context "without authenticated user" do
    describe "get #index" do
      before :each do
        get admin_campaigns_path
      end

       it "responds with redirect" do
        expect(response).not_to be_success
        expect(response).to have_http_status(301)
        expect(response.redirect_url).to eql(root_url)
      end
    end
  end


end
