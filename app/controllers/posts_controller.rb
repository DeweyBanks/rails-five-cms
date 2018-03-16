class PostsController < ApplicationController

  def index
    @categories = Category.all
    @featured_post = Post.featured
    @page = "index"
    if params[:filter].present?
      @posts = Post.where(category: Category.find_by(name: params[:filter])).order('created_at DESC').limit(7)
    elsif params[:tag].present?
      @posts = Post.tagged_with(params[:tag]).order('created_at DESC').limit(7)
    elsif params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC").limit(7)
    else
      @posts = Post.all.order('created_at DESC').limit(7)
    end

    @first_blog_row = []
    @second_blog_row = []
    @third_blog_row = []

    @posts.each_with_index do |post, index|
      case index
      when 0..1
        @first_blog_row << post
      when 2..4
        @second_blog_row << post
      else
        @third_blog_row << post
      end
    end

    respond_to do |f|
      f.html {render :index }
      f.json {render json: @posts}
    end
  end

  def show
    @page = "show"
    @post = Post.find_by(slug: params[:slug])
  end

end

