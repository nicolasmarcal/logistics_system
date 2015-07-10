class Locality < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :destiny_routes, :class_name => "Route", :foreign_key => "origin_locality_id"
  has_many :origin_routes, :class_name => "Route", :foreign_key => "destination_locality_id"

  def journeys_to(destination)
    destiny_routes.map{ |route| route.route_journeys(destination) }
  end
end
