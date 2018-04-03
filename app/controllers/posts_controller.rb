class PostsController < ApplicationController

  def index
    @categories = Category.all
    @featured_post = Category.find_by(name: "Blog").featured_post
    @page = "index"

    if params[:filter].present?
        category = Category.find_by(name: params[:filter])
      if params[:id].present?
        @posts = Post.published.last_loaded(params[:id]).limit(7).order("created_at desc").where(category: category)
      else
        @posts = Post.published.limit(7).order("created_at desc").where(category: category)
      end
      @featured_post = category.featured_post
    elsif params[:tag].present?
      if params[:id].present?
        @posts = Post.published.limit(7).where('id > ?', params[:id]).order("created_at desc").tagged_with(params[:tag])
      else
        @posts = Post.published.limit(7).order("created_at desc").tagged_with(params[:tag])
      end
    elsif params[:search]
      if params[:id].present?
        @posts = Post.published.last_loaded(params[:id]).limit(7).order("created_at desc").search(params[:search])
      else
        @posts = Post.published.search(params[:search]).limit(7).order("created_at desc")
      end
    else
      if params[:id].present?
        @posts = Post.published.last_loaded(params[:id]).limit(7)
      else
        @posts = Post.published.limit(7).order("created_at desc")
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @page = "show"
    @post = Post.find_by(slug: params[:slug])
    if @post.status != "published"
      redirect_to root_path
    end
    @recent_posts = Post.limit(5)
  end

end

