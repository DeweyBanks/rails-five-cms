require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "POST #create" do

    context "Comment on a Post" do
      before :each do
        @campaign = FactoryBot.create(:campaign, name: "Healthy Living")
        @category = Category.find_by(name: "News")
        @post = FactoryBot.create(:post, category: @category, campaign: @campaign)
      end

      let(:valid_params) {
        {'comment' => {
          'first_name' => 'John',
          'last_name' => 'Smith',
          'email' => 'jsmith@example.com',
          'body' => 'Test Comment'
          },
          'post_slug' => @post.slug
        }
      }

      it 'creates a new Comment' do
        expect {
          post :create, params: valid_params
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, params: valid_params
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end

      it "redirects to the created comment" do
        from post_path(@post)
        post :create, params: valid_params
        expect(response).to redirect_to(post_path(@post))
      end
    end

    context "Comment on a Comment" do
      before :each do
        @campaign = FactoryBot.create(:campaign, name: "Healthy Living")
        @category = Category.find_by(name: "News")
        @post = FactoryBot.create(:post, category: @category, campaign: @campaign)
        @comment = FactoryBot.create(:comment, commentable_type: "Post", commentable_id: @post.id)
      end

      let(:valid_params) {
        {'comment' => {
          'first_name' => 'Jane',
          'last_name' => 'Doe',
          'email' => 'jdoe@example.com',
          'body' => 'Reply Test Comment'
          },
          'comment_id' => @comment.id
        }
      }

      it 'creates a new Comment' do
        expect {
          post :create, params: valid_params
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, params: valid_params
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end

      it "redirects to the created comment" do
        from post_path(@post)
        post :create, params: valid_params
        expect(response).to redirect_to(post_path(@post))
      end
    end

  end
end
