module Admin
  class PostsController < BaseController
    before_action :set_post, only: [:show, :edit, :update, :publish_post, :destroy]

    def index
      @posts = Post.all
      case params['sort']
      when "title"
        @posts = @posts.order("title #{sort_direction}").paginate(:page => params[:page])
      when "category"
        @posts = @posts.includes(:category).order("categories.name #{sort_direction}").paginate(:page => params[:page])
      when "campaign"
         @posts = @posts.includes(:campaign).order("campaigns.name #{sort_direction}").paginate(:page => params[:page])
      else
        @posts = Post.all.order(sort_column + " " + sort_direction).page params[:page]
      end
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
        ['slug', 'category', 'campaign', 'title', 'status', 'created_at'].include?(params[:sort]) ? params[:sort] : "title"
      end

      def sort_direction
        params[:direction] == "desc" ? params[:direction] : "asc"
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
          :featured,
          pictures_attributes: [:id, :image, :caption, :alt, :_destroy]
          )
      end
  end
end
