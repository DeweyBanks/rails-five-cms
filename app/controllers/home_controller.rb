class HomeController < ApplicationController
  skip_before_action :authenticate_admin!, :only => [:index, :show]

  def index
  end

  def show
    if valid_page?
      # @physicians = Commander.all
      # @coaches = Commander.all
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
