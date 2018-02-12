require 'rails_helper'

RSpec.describe Admin::MessagesController, type: :controller do
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

    it "assigns all messages" do
      expect(assigns[:messages]).to eq(Message.all)
    end
  end

  describe "get #show" do
    before :each do
      admin = FactoryBot.create(:user)
      sign_in(admin)
      message = FactoryBot.create(:message)
      get :show, params: { id: message.id }
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders show template" do
      expect(response).to render_template("show")
    end
  end

  describe "post #destroy" do
    it "deletes the Message" do
      admin = FactoryBot.create(:user)
      sign_in(admin)
      message = FactoryBot.create(:message)
      expect{
        delete :destroy, params: {'id' => message.id}
      }.to change(Message, :count).by(-1)
    end
  end
end
