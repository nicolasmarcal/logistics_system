class Route < ActiveRecord::Base
  validates_presence_of :distance, :origin_locality_id, :destination_locality_id

  attr_accessor :journeys, :visited

  belongs_to :origin_locality, :class_name => "Locality", :foreign_key => "origin_locality_id"
  belongs_to :destination_locality, :class_name => "Locality", :foreign_key => "destination_locality_id"

  def route_journeys(destination, journeys = [], arr = [])
    arr << self

    if destination_locality_id == destination.id || origin_locality_id == destination.id
      return journeys << arr
    end

    destination_locality.destiny_routes.each do |route|
      if route.destination_locality_id == destination.id || route.origin_locality_id == destination.id
        arr << route
        return journeys << arr
      else
        return route.route_journeys(destination, journeys, arr)
      end
    end
  end

  def journeys
    @journeys ||= []
  end
end
