class Api::V1::JourneysController < Api::ApiController
  
  skip_before_action :verify_authenticity_token

  def create
    journey = JourneyMaker.new(journey_params)

    if journey.valid?
      render json: { journey: journey.route.to_json }, status: :created
    else
      render json: { errors: journey.errors }, status: :unprocessable_entity
    end
  end

  private

  def journey_params
    params.require(:journeys).permit(
      :origin_name, :destiny_name, :truck_autonomy, :liter_price
    )
  end
end