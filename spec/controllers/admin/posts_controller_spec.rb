require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do

  describe "get #index" do
    before :each do
      get :index
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "assigns all post" do
      expect(assigns[:posts]).to eq(Post.all.order('created_at DESC'))
    end
  end

  describe "get #show" do
    before :each do
      counter = rand(0...100)
      post = FactoryBot.create(:post, slug: "test-post-#{counter}", title: "Test Post")
      get :show, params: { id: post.slug }
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders show template" do
      expect(response).to render_template("show")
    end
  end

  describe "get #new" do

    it "assigns a new Post instance variable" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "post #create" do
    context "with valid attributes" do

      it "saves a new Post to the database" do
        attrs = attributes_for(:post)
        expect {
          post :create, params: { 'post' => attrs }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the Post show" do
        attrs = attributes_for(:post)
        post :create, params: { 'post' => attrs }
        expect(response).to redirect_to admin_post_url(Post.last.slug)
      end
    end

    context "without valid attributes" do
      before :each do
        @attrs = attributes_for(:post, slug: "test-bad-post", title: "Test", campaign: nil, category: nil)
      end

      it "does not save the new Post" do
        expect{
          post :create, params: { 'post' => @attrs }
        }.to_not change(Post,:count)
      end

      it "re-renders the new method" do
        post :create, params: { 'post' => @attrs }
        expect(response).to render_template :new
      end
    end
  end

  describe "post #update" do
    before :each do
      @post = create(:post,
        title: 'Healthy Living On The Road.'
      )
    end
    it "changes the post's attributes" do
      patch :update, params: {
        id: @post.slug,
        post: FactoryBot.attributes_for(:post,
          title: 'Healthy In NYC',
          body: 'Pizza in New York . . .'
        )
      }
      expect(assigns(:post).title).to eq('Healthy In NYC')
      expect(assigns(:post).body).to eq('Pizza in New York . . .')
      expect(response).to redirect_to(admin_post_url(@post.slug))
    end

  end

  describe "post #destroy" do
    it "deletes the Post" do
      @post = FactoryBot.create(:post)
      expect{
        delete :destroy, params: {'id' => @post.slug}
      }.to change(Post, :count).by(-1)
    end
  end
end
