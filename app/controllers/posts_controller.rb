class PostsController < ApplicationController
  skip_before_action :authenticate_admin!, :only => [:index, :show]

  def index
    @posts = Post.includes(:comments).order('created_at DESC')
    respond_to do |f|
      f.html {render :index }
      f.json {render json: @posts}
    end
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end

end
