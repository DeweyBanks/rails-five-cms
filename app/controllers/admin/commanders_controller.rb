module Admin
  class CommandersController < BaseController
    before_action :set_commander, only: [:show, :edit, :update, :destroy]

    def index
      @commanders = Commander.all.order(sort_column + " " + sort_direction).page params[:page]
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

    def update_commanders
      type_id = CommanderType.find_by(name: "Physician").id
      file = File.read('public/commanders/commander_data.json')
      data_hash = JSON.parse(file)
      data_hash["data"].each do |d|
        c = Commander.find_by(emps_id: d["id"])
        if c.nil?
          c = Commander.new
          if d["title"].present?
            c.title = d["title"]
          else
            c.title = "Title Missing"
          end
          if d["name"].present?
            c.first_name = d["name"].split(" ").first
            c.last_name = d["name"].split(" ").last
          else
            c.first_name = "Name Missing"
            c.last_name = "Name Missing"
          end
          c.about = d["about"]
          c.commander_type_id = type_id
          c.emps_id = d["id"]
          c.facility_id = d["facility_id"]
          c.avatar = File.new("/test_images/commanders/doctor#{rand(1..9)}.jpg", "r")
        else
           if d["name"].present?
            c.first_name = d["name"].split(" ").first
            c.last_name = d["name"].split(" ").last
            d.except!("name")
            c.avatar = File.new("/test_images/commanders/doctor#{rand(1..9)}.jpg", "r")
            c.update(d)
          else
            c.first_name = "Name Missing"
            c.last_name = "Name Missing"
          end
        end
        c.save
      end
      @commanders = Commander.all
      render :index
    end

    private

      def sort_column
        Post.column_names.include?(params[:sort]) ? params[:sort] : "commander_type_id, title, first_name, last_name"
      end

      def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      end

      def set_commander
        @commander = Commander.find(params[:id])
      end

      def commander_params
        params.require(:commander).permit(:title, :first_name, :last_name, :about, :avatar, :commander_type_id, :emps_id, :facility_id)
      end
  end
end
