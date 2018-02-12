class HomeController < ApplicationController

  def index
  end

  def show
    if valid_page?
      render template: "home/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  def email_list
    email = email_params["email"]
  end

  private

    def email_params
      params.require(:connection).permit(:email)
    end

    def valid_page?
      File.exist?(Pathname.new(Rails.root + "app/views/home/#{params[:page]}.html.erb"))
    end

end
