class HomeController < ApplicationController

  def index
    @page = "index"
    @posts = Post.published.limit(5).order("created_at desc")
  end

  def show
    @page = params[:page]

    if @page == "commanders_in_wellness"
      @physicians = Commander.physicians.limit(9)
      @coaches = Commander.coaches.limit(9)
    end

    @posts = Post.limit(5) if @page == "about"

    if valid_page?
      render template: "home/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private

    def valid_page?
      File.exist?(Pathname.new(Rails.root + "app/views/home/#{params[:page]}.html.erb"))
    end

end
