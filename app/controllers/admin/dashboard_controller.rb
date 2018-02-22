module Admin
  class DashboardController < BaseController
    before_action :authenticate_user!

    def index
    end

    def update_commanders
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
          c.commander_type_id = CommanderType.find_by(name: "Physician").id
          c.emps_id = d["id"]
          c.facility_id = d["facility_id"]
        end
        c.save
      end
      render :index
    end

  end
end
