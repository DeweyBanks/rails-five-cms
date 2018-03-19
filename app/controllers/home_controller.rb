class HomeController < ApplicationController

  def index
    @page = "index"
    @posts = Post.limit(5).order('created_at DESC')
  end

  def show
    @commanders = Commander.all.limit(9)
    @page = params[:page]
    if @page == "about"
      @posts = Post.all.order('created_at DESC')
    end
    if valid_page?
      render template: "home/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  def subscribe
    email = subscription_params["email"]
    redirect_back(fallback_location: root_path)
  end

  private

    def subscription_params
      params.require(:subscribe).permit(:email)
    end

    def valid_page?
      File.exist?(Pathname.new(Rails.root + "app/views/home/#{params[:page]}.html.erb"))
    end

end
