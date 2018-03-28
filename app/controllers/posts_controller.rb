class PostsController < ApplicationController

  def index
    @categories = Category.all
    @featured_post = Post.featured
    @page = "index"

    if params[:filter].present?
      if params[:id].present?
        @posts = Post.last_loaded(params[:id]).limit(7).order("created_at desc").where(category: Category.find_by(name: params[:filter]))
      else
        @posts = Post.limit(7).order("created_at desc").where(category: Category.find_by(name: params[:filter]))
      end
    elsif params[:tag].present?
      if params[:id].present?
        @posts = Post.limit(7).where('id > ?', params[:id]).order("created_at desc").tagged_with(params[:tag])
      else
        @posts = Post.limit(7).order("created_at desc").tagged_with(params[:tag])
      end
    elsif params[:search]
      if params[:id].present?
        @posts = Post.last_loaded(params[:id]).limit(7).order("created_at desc").search(params[:search])
      else
        @posts = Post.search(params[:search]).limit(7).order("created_at desc").limit(7)
      end
    else
      if params[:id].present?
        @posts = Post.last_loaded(params[:id]).limit(7)
      else
        @posts = Post.limit(7).order("created_at desc")
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

