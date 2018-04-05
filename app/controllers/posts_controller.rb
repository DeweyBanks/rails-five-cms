class PostsController < ApplicationController

  def index
    @categories = Category.all
    @featured_post = Category.find_by(name: "Blog").featured_post
    if params[:category]
      @featured_post = Category.find(params[:category]).featured_post
    end
    @page = "index"
    if params[:id]
      @posts = Post.last_loaded(params[:id]).filter(params.slice(:category, :tagged_with, :search))
    else
      @posts = Post.filter(params.slice(:category, :tagged_with, :search))
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @page = "show"
    @post = Post.find_by(slug: params[:slug])
    unless @post.published?
      redirect_to root_path
    end
    @recent_posts = Post.limit(5)
  end

end
