class PostsController < ApplicationController

  def index
    @page = "index"
    @categories = Category.all
    if params[:category]
      @featured_post = Category.find(params[:category]).featured_post
    end
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
    if @post.locked
      redirect_to locked_path(@post.slug) and return
    end
    unless @post.published?
      redirect_to root_path
    end
    @recent_posts = Post.limit(5)
  end

  def locked
    @post = Post.find_by(slug: params[:slug])
  end

  def unlock
    @post = Post.find_by(slug: params[:slug])
    verified_username = (params["username"] == @post.username)
    if @post && @post.user_verified(verified_username, params[:password])
    else
      flash.now.alert = 'Username or password is invalid'
      render :locked
    end
  end

end
