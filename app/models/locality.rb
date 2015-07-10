class Locality < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :destiny_routes, :class_name => "Route", :foreign_key => "origin_locality_id"
  has_many :origin_routes, :class_name => "Route", :foreign_key => "destination_locality_id"

  def journeys_to(destination)
    journeys = []

    destiny_routes.map{ |route| route.route_journeys(destination) }.each do |routes|
      uniq_routes = routes.uniq.flatten
      arr = []
  
      journeys << [uniq_routes] if uniq_routes.one? && uniq_routes.first.origin_locality == self && uniq_routes.first.destination_locality == destination
      while uniq_routes.select{ |r| r.origin_locality != self }.any?{ |r| !r.visited } do
        uniq_routes.select{|r| !r.visited}.each do |route|
          arr << route
          route.visited = true unless route.destination_locality.destiny_routes.any?{ |r| !r.visited }

          if route.destination_locality == destination
            journeys << arr
            arr = []
            break
          end

        end
      end
    end

    journeys
  end
end
