class JourneyMaker
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :origin_name, :destiny_name, :truck_autonomy, :liter_price, :origin, :destiny,
                :direct_route, :journeys, :cheap_route

  validates_presence_of :origin, :destiny, :truck_autonomy, :liter_price

  def initialize(params={})
    params.each do |key, value|
      self.send "#{key}=", value
    end
  end

  def route
    {
      :journey => cheap_route.map { |route| [route.origin_locality.name, route.destination_locality.name] },
      :cost => journey_cost(cheap_route.map(&:distance).sum) 
    }
  end

  private

  def cheap_route
    @cheap_route ||= origin.journeys_to(destiny).sort_by{ |journeys| journey_cost(journeys.map(&:distance).sum) }.first
  end

  def journey_cost(distance)
    (distance / @truck_autonomy) * liter_price.to_f
  end

  def direct_route
    @direct_route ||= Route.by_origin_and_destination(origin, destiny).first
  end

  def origin
    @origin ||= Locality.find_by(name: @origin_name)
  end

  def destiny
    @destiny ||= Locality.find_by(name: @destiny_name)
  end
end