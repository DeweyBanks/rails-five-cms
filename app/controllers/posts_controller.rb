class PostsController < ApplicationController

  def index
    @categories = Category.all
    @page = "index"
    if params[:filter].present?
      @posts = Post.where(category: params[:filter]).includes(:comments).order('created_at DESC')
    elsif params[:tag].present?
      @posts = Post.tagged_with(params[:tag]).includes(:comments).order('created_at DESC')
    elsif params[:search]
      @posts = Post.search(params[:search]).includes(:comments).order("created_at DESC")
    else
      @posts = Post.all.order('created_at DESC')
    end
    respond_to do |f|
      f.html {render :index }
      f.json {render json: @posts}
    end
  end

  def show
    @page = "show"
    @post = Post.includes(:comments).find_by(slug: params[:slug])
  end

end

