class CommandersController < ApplicationController

  def index
    case params['filter']
    when "physicians"
      @commanders = Commander.physicians_scope
    when "coaches"
      @commanders = Commander.coaches_scope
    else
      @commanders = Commander.all
    end
    respond_to do |f|
      f.html {render :index }
      f.json {render json: @commanders}
    end
  end

  def show
    @commander = Commander.find(params[:id])
  end

end
