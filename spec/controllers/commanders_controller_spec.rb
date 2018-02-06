require 'rails_helper'

RSpec.describe CommandersController, type: :controller do
  context "get #index without filter" do
    before :each do
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

  context "get #index with Physicians filter" do
    let(:params) { { filter: 'Physicians' } }
    before :each do
      get :index, params: params
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "assigns all commanders" do
      expect(assigns[:commanders].length).to eq(Commander.physicians_scope.length)
    end
  end

  context "get #index Whith Coaches filter" do
    let(:params) { { filter: 'Coaches' } }
    before :each do
      get :index, params: params
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "assigns all commanders" do
      expect(assigns[:commanders].length).to eq(Commander.coaches_scope.length)
    end
  end

  context "get #show" do
    before :each do
      commander = create(:commander)
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

end
