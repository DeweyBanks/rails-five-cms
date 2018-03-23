class PostsController < ApplicationController

  def index
    @categories = Category.all
    @featured_post = Post.includes(:category).featured
    @page = "index"

    if params[:filter].present?
      if params[:id].present?
        @posts = Post.last_loaded(params[:id]).limit(7).where(category: Category.find_by(name: params[:filter]))
      else
        @posts = Post.limit(7).where(category: Category.find_by(name: params[:filter]))
      end
    elsif params[:tag].present?
      if params[:id].present?
        @posts = Post.last_loaded(params[:id]).tagged_with(params[:tag]).limit(7)
      else
        @posts = Post.tagged_with(params[:tag]).limit(7)
      end
    elsif params[:search]
      if params[:id].present?
        @posts = Post.last_loaded(params[:id]).search(params[:search]).limit(7)
      else
        @posts = Post.search(params[:search]).limit(7)
      end
    else
      if params[:id].present?
        @posts = Post.last_loaded(params[:id]).limit(7)
      else
        @posts = Post.limit(7)
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
    @recent_posts = Post.limit(5)
  end

end

