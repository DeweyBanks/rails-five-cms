require 'csv'
namespace :location do
  desc "Populate Locations"
  task create_locations: :environment do
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'ehe_health_locations.csv'))
    csv = CSV.parse(csv_text, :headers => true)

    csv.each do |row|
      Location.create({
        name: row["name"],
        location_type: row["type"],
        street: row["address"],
        city: row["city"],
        state: row["state"],
        zip: row["zip"],
        phone: row["phone"],
        latitude: row["latitude"],
        longitude: row["longitude"],
        })
    end
  end

end
