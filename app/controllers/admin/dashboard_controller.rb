module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_admin!

    def index
    end

    protected

      def authenticate_admin!
        redirect_to user_session_path, alert: 'Must be signed in to view this page.' unless current_user && current_user.is_admin?
      end

  end
end
