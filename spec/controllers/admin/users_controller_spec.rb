require 'rails_helper'
require 'faker'

RSpec.describe Admin::UsersController, type: :controller do
  describe "get #index" do
    before :each do
      admin = FactoryBot.create(:user, super_admin: true)
      sign_in(admin)
      get :index
    end
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "assigns all users" do
      expect(assigns[:users]).to eq(User.all)
    end
  end

  describe "get #new" do
    before :each do
      admin = FactoryBot.create(:user, super_admin: true)
      sign_in(admin)
      get :new
    end

    it "assigns a new User instance variable" do
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new template" do
      expect(response).to render_template(:new)
    end
  end

  describe "post #create" do
    context "with valid attributes" do
      it "saves a new User to the database" do
        admin = FactoryBot.create(:user, super_admin: true)
        sign_in(admin)
        expect {
          post :create, params: { 'user' => attributes_for(:user, email: Faker::Internet.email ) }
        }.to change(User, :count).by(1)
      end
    end

    context "without valid attributes" do
      before :each do
        admin = FactoryBot.create(:user, super_admin: true)
        sign_in(admin)
      end

      it "does not save the new User" do
        expect{
          post :create, params: { 'user' => attributes_for(:user, email: nil) }
        }.to_not change(User,:count)
      end

      it "re-renders the new method" do
        post :create, params: { 'user' => attributes_for(:user, email: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe "post #update" do
    it "updates User's attributes" do
      admin = FactoryBot.create(:user, super_admin: true)
      sign_in(admin)
      @user = FactoryBot.create(:user, first_name: 'Joe')
      attrs = @user.attributes
      attrs['first_name'] = 'Jane'
      patch :update, params: {
        id: @user.id,
        user: attrs
      }
      expect(assigns(:user).first_name).to eql('Jane')
    end
  end

  describe "post #destroy" do
    it "deletes the User" do
      admin = FactoryBot.create(:user, super_admin: true)
      sign_in(admin)
      user = FactoryBot.create(:user)
      expect{
        delete :destroy, params: {'id' => user.id}
      }.to change(User, :count).by(-1)
    end
  end
end
