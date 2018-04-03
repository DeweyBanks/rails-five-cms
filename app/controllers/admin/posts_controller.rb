module Admin
  class PostsController < BaseController
    skip_before_action :verify_authenticity_token, only: [:set_featured]
    before_action :set_post, only: [:show, :edit, :update, :publish_post, :destroy]

    def index
      case params['sort']
      when "title"
        @posts = Post.includes(:category, :campaign).order("title #{sort_direction}").paginate(:page => params[:page], :per_page => 10)
      when "category"
        @posts = Post.includes(:category, :campaign).order("categories.name #{sort_direction}").paginate(:page => params[:page], :per_page => 10)
      when "campaign"
         @posts = Post.includes(:category, :campaign).order("campaigns.name #{sort_direction}").paginate(:page => params[:page], :per_page => 10)
      when "status"
        @posts = Post.includes(:category, :campaign).order("status #{sort_direction}").paginate(:page => params[:page], :per_page => 10)
      when "created_at"
        @posts = Post.includes(:category, :campaign).order("created_at #{sort_direction}").paginate(:page => params[:page], :per_page => 10)
      else
        @posts = Post.includes(:category, :campaign).all.order("created_at desc").paginate(:page => params[:page], :per_page => 10)
      end
    end

    def show
    end

    def archived
      @posts = Post.archived.includes(:category, :campaign).order("created_at desc").paginate(:page => params[:page], :per_page => 10)
    end

    def set_featured
      @category = Category.find(params["category"])
      @post = Post.find params[:id]
      @post.featured = true
      respond_to do |format|
        if @post.save
          format.html { redirect_to admin_category_path(@category), notice: 'Post was set as featured.' }
          format.js   {}
          format.json { render json: @category, status: :created, location: @category }
        else
          format.html { render action: "show" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
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
      binding.pry
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
          :featured,
          :published_at
          )
      end
  end
end
