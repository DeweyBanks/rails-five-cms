class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: "foo", password: "bar", unless: ->{ Rails.env.development? }

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :dob, :gender, :employer, :zipcode])
    end

    def after_sign_in_path_for(resource)
      if current_user.is_admin?
        admin_path
      else
        root_path
      end
    end
end
