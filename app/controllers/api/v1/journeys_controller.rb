class Api::V1::JourneysController < Api::ApiController

  def create
    journey = JourneyMaker.new(journey_params)

    if journey.valid?
      respond_to do |format|
        format.json do
          render :json { journey.route.to_json, status: :created }
        end
      end
    else
      respond_to do |format|
        format.json do
          render :json { errors: journey.errors }, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def journey_params
    params.require(:journey).permit(
      :origin_name, :destiny_name, :truck_autonomy, :liter_price
    )
  end
    
  end
end