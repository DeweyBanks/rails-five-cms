module Admin
  class MessagesController < BaseController

    def index
      @messages = Message.all.order(sort_column + " " + sort_direction).page params[:page]
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

    private

      def sort_column
        Post.column_names.include?(params[:sort]) ? params[:sort] : "first_name, last_name, company_name, email, interest"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      end

  end
end
