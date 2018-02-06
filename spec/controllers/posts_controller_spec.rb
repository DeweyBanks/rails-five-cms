require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  context "get #index without tags" do
    before :each do
      get :index
    end
     it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "assigns all posts" do
      expect(assigns[:posts]).to eq(Post.all)
    end
  end

  context "get #index with tags" do
    campaign = FactoryBot.create(:campaign, name: "Healthy Living")
    category = Category.find_by(name: "News")
    post = FactoryBot.create(:post, category: category, campaign: campaign, all_tags: "Health")
    let(:params) { { tag: 'Health' } }
    before :each do
      get :index, params: params
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "assigns all posts tagged with 'Health'" do
      expect(assigns[:posts].length).to eq(Post.tagged_with("Health").length)
    end
  end

  context "get #show" do
    before :each do
      campaign = FactoryBot.create(:campaign, name: "Healthy Living")
      category = Category.find_by(name: "News")
      post = FactoryBot.create(:post, category: category, campaign: campaign)
      get :show, params: { slug: post.slug }
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
