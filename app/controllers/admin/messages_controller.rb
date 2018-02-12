module Admin
  class MessagesController < BaseController

    def index
      @messages = Message.all
    end

    def show
      @message = Message.find(params[:id])
    end

     def destroy
      @message = Message.find(params[:id])
      @message.destroy
      respond_to do |format|
        format.html { redirect_to admin_messages_url, notice: 'Message was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  end
end
