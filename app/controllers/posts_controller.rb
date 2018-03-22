class PostsController < ApplicationController

  def index
    @categories = Category.all
    @featured_post = Post.featured
    @page = "index"
    if params[:id].present?
      @posts = Post.where('id < ?', params[:id]).limit(7)
    elsif params[:filter].present?
      @posts = Post.limit(7).where(category: Category.find_by(name: params[:filter]))
    elsif params[:tag].present?
      @posts = Post.tagged_with(params[:tag]).limit(7)
    elsif params[:search]
      @posts = Post.search(params[:search]).limit(7)
    else
      @posts = Post.limit(7)
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

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @page = "show"
    @post = Post.find_by(slug: params[:slug])
  end

end

