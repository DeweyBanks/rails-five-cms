module Admin
  class PostsController < BaseController
    before_action :set_post, only: [:show, :edit, :update, :publish_post, :destroy]

    def index
      @posts = Post.all
      case params['sort']
      when "title"
        @posts = @posts.order("title #{sort_direction}").paginate(:page => params[:page], :per_page => 10)
      when "category"
        @posts = @posts.includes(:category).order("categories.name #{sort_direction}").paginate(:page => params[:page], :per_page => 10)
      when "campaign"
         @posts = @posts.includes(:campaign).order("campaigns.name #{sort_direction}").paginate(:page => params[:page], :per_page => 10)
      else
        @posts = Post.all.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 10)
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

    def edit_multiple
      @posts = Post.find(params[:post_ids])
    end

    def update_multiple
      @posts = Post.find(params["post_ids"])
      @posts.reject! do |post|
        post.update_attributes(post_params.reject { |k,v| v.blank? })
      end
      if @posts.empty?
        redirect_to(admin_posts_url) and return
      else
        @post = Post.new(post_params)
        render :edit_multiple
      end

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
          :all_keywords,
          :main_image,
          :meta_description,
          :status,
          :featured
          )
      end
  end
end
