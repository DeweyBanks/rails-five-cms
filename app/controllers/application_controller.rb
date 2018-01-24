class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: "foo", password: "bar", unless: ->{ Rails.env.development? }

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :dob, :gender, :employer, :zipcode])
    end

    def authenticate_admin!
      redirect_to user_session_path, alert: 'Must be signed in to view this page.' unless current_user && current_user.is_admin?
    end
end
