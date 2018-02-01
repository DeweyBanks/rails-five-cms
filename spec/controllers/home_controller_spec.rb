require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context "GET #index" do
    before do
      get :index
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      expect(response).to render_template("index")
    end
  end

  context "Get #show existing page" do
    let(:params) { { page: 'about' } }
    it "responds with correct template" do
      get :show, params: params
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("about")
    end
  end

  context "Get #show missing or non-existant page" do
    let(:params) { { page: 'foo' } }
    it "responds with 404" do
      get :show, params: params
      expect(response).to have_http_status(404)
    end
  end

end
