class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction
end
