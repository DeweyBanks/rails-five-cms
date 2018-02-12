module Admin
  class CommandersController < BaseController
    before_action :set_commander, only: [:show, :edit, :update, :destroy]

    def index
      @commanders = Commander.all
    end

    def show
    end

    def new
      @commander = Commander.new
    end

    def edit
    end

    def create
      @commander = Commander.new(commander_params)

      respond_to do |format|
        if @commander.save
          format.html { redirect_to admin_commander_path(@commander), notice: 'Commander was successfully created.' }
          format.json { render :show, status: :created, location: @commander }
        else
          format.html { render :new }
          format.json { render json: @commander.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
       respond_to do |format|
        if @commander.update(commander_params)
          format.html { redirect_to admin_commander_path(@commander), notice: 'Commander was successfully updated.' }
          format.json { render :show, status: :ok, location: @commander }
        else
          format.html { render :edit }
          format.json { render json: @commander.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @commander.destroy
      respond_to do |format|
        format.html { redirect_to admin_commanders_path, notice: 'Commander was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_commander
      @commander = Commander.find(params[:id])
    end

    def commander_params
      params.require(:commander).permit(:title, :first_name, :last_name, :about, :avatar, :commander_type_id)
    end
  end
end
