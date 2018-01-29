class PostsController < ApplicationController

  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).includes(:comments).order('created_at DESC')
    else
      @posts = Post.all
    end
    respond_to do |f|
      f.html {render :index }
      f.json {render json: @posts}
    end
  end

  def show
    @post = Post.includes(:comments).find_by(slug: params[:slug])
  end

end

