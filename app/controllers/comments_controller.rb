class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

   def create
    @comment = @commentable.comments.new comment_params

    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def show
  end

  private


  def comment_params
    params.require(:comment).permit(
      :first_name,
      :last_name,
      :website,
      :body
    )
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end

end


