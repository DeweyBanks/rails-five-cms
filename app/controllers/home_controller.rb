class HomeController < ApplicationController

  def index
    @page = "index"
    @posts = Post.all.order('created_at DESC')
  end

  def show
    @page = params[:page]
    if valid_page?
      render template: "home/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  def subscribe
    email = subscription_params["email"]
  end

  private

    def subscription_params
      params.require(:subscribe).permit(:email)
    end

    def valid_page?
      File.exist?(Pathname.new(Rails.root + "app/views/home/#{params[:page]}.html.erb"))
    end

end
