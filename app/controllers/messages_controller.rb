class MessagesController < ApplicationController

  def new
    @message = Message.new
  end


  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        MessageMailer.notification_email(@message).deliver_later

        format.html { redirect_back( fallback_location: (request.referer || root_path), notice: "Thank you for your interest!") }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def message_params
      params.require(:message).permit(:first_name, :last_name, :company_name, :email, :interest, :comment)
    end
end
