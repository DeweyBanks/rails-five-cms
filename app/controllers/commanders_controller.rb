class CommandersController < ApplicationController

  def index
    if params[:id]
      @commanders = Commander.where('id < ?', params[:id]).limit(5)
    else
      case params['filter']
      when "physicians"
        @commanders = Commander.physicians_scope
      when "coaches"
        @commanders = Commander.coaches_scope
      else
        @commanders = Commander.all
      end
    end
    respond_to do |f|
      f.html
      f.js
    end
  end

  def show
    @commander = Commander.find(params[:id])
  end

end
