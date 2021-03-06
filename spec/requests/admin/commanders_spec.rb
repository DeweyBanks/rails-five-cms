require 'rails_helper'

RSpec.describe "Admin/Commanders" do

  context "without authenticated user" do
    describe "get #index" do
      before :each do
        get admin_commanders_path
      end

       it "responds with redirect" do
        expect(response).not_to be_success
        expect(response).to have_http_status(302)
        expect(response.redirect_url).to eql(new_user_session_url)
      end
    end
  end

end
