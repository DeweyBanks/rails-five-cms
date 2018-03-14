module Admin
  class PostsController < BaseController
    helper_method :sort_column, :sort_direction
    before_action :set_post, only: [:show, :edit, :update, :publish_post, :destroy]

    def index
      @posts = Post.all.limit(20).order(sort_column + " " + sort_direction)
    end

    def show
    end

    def new
      @campaigns = Campaign.all
      @post = Post.new
    end

    def edit
    end

    def create
      @post = Post.new(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to admin_post_path(@post), notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @post.update!(post_params)
          format.html { redirect_to admin_post_path(@post), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    def publish_post
      @post.status = "published"
      @post.save
      respond_to do |format|
        format.html { redirect_to admin_post_path(@post), notice: 'Post has been published.' }
        format.json { head :no_content }
      end
    end

    def destroy
      @post.destroy
      respond_to do |format|
        format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

      def sort_column
        Post.column_names.include?(params[:sort]) ? params[:sort] : "slug, title, status"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      end

      def set_post
        @post = Post.find_by(slug: params[:id])
      end

      def post_params
        params.require(:post).permit(
          :slug,
          :title,
          :body,
          :campaign_id,
          :category_id,
          :all_tags,
          :main_image,
          :meta_description,
          :status,
          pictures_attributes: [:id, :image, :caption, :alt, :_destroy]
          )
      end
  end
end
