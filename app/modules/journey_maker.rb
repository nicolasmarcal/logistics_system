class JourneyMaker
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :origin_name, :destiny_name, :truck_autonomy, :liter_price, :origin, :destiny

  validates_presence_of :origin, :destiny, :truck_autonomy, :liter_price

  def initialize(params)
    params.each do |key, value|
      self.send "#{key}=", value
    end
  end

  def route
    
  end

  private

  def origin
    @origin ||= Locality.by_name(@origin_name).first
  end

  def destiny
    @destiny ||= Locality.by_name(@destiny_name).first
  end
end