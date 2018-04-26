class LocationsController < ApplicationController

  def index
    if params[:l]
      sw_lat, sw_lng, ne_lat, ne_lng = params[:l].split(",")
      center    = Geocoder::Calculations.geographic_center([[sw_lat, sw_lng], [ne_lat, ne_lng]])
      distance  = Geocoder::Calculations.distance_between(center, [sw_lat, sw_lng])
      box       = Geocoder::Calculations.bounding_box(center, distance)
      @locations = Location.within_bounding_box(box)
    elsif params[:near]
      @locations = Location.near(params[:near], 250)
    else
      @locations = Location.all
      @default = Location.where(name: "New York");
    end
  end

end
