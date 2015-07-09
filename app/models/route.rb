class Route < ActiveRecord::Base
  validates_presence_of :distance, :origin_locality_id, :destination_locality_id

  belongs_to :origin_locality, :class_name => "Locality", :foreign_key => "origin_locality_id"
  belongs_to :destination_locality, :class_name => "Locality", :foreign_key => "destination_locality_id"

end
