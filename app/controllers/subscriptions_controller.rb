class SubscriptionsController < ApplicationController

  def create
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
        format.html { redirect_back( fallback_location: (request.referer || root_path), notice: "Thank you for your interest!") }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { redirect_back( fallback_location: (request.referer || root_path)) }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def subscription_params
      params.require(:subscription).permit(:email)
    end
end
