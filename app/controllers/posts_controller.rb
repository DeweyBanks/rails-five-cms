class PostsController < ApplicationController

  def index
    @page = "index"
    if params[:tag].present?
      @posts = Post.tagged_with(params[:tag]).includes(:comments).order('created_at DESC')
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

