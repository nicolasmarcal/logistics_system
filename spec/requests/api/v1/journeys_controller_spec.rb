require 'spec_helper'

describe Api::V1::JourneysController, type: :controller do
  let!(:locality_a){ FactoryGirl.create(:locality, :name => "A") }
  let!(:locality_b){ FactoryGirl.create(:locality, :name => "B") }
  let!(:locality_c){ FactoryGirl.create(:locality, :name => "C") }
  let!(:locality_d){ FactoryGirl.create(:locality, :name => "D") }

  let!(:route_one){ FactoryGirl.create(:route, :origin_locality => locality_a, :destination_locality => locality_c, :distance => 10) }
  let!(:route_two){ FactoryGirl.create(:route, :origin_locality => locality_a, :destination_locality => locality_b, :distance => 50) }
  let!(:route_tree){ FactoryGirl.create(:route, :origin_locality => locality_c, :destination_locality => locality_b, :distance => 20) }
  let!(:route_four){ FactoryGirl.create(:route, :origin_locality => locality_c, :destination_locality => locality_d, :distance => 50) }
  let!(:route_five){ FactoryGirl.create(:route, :origin_locality => locality_d, :destination_locality => locality_b, :distance => 100) }
  
  describe "create" do
    context "when Journey is not valid" do
      it "return errors" do
        request.accept = "application/json"
        post 'create', { journeys: { origin_name: "BLA" } }

        expect(response.response_code).to eq(422)

        parsed_body = JSON.parse(response.body)
        
        expect(parsed_body).to eq("errors" => {"origin"=>["can't be blank"], "destiny"=>["can't be blank"], "truck_autonomy"=>["can't be blank"], "liter_price"=>["can't be blank"]})
      end
    end

    context "when Journey is valid" do
      it "return route" do
        request.accept = "application/json"
        post 'create', { journeys: { origin_name: "A", destiny_name: "B", truck_autonomy: 10.0, liter_price: 2.5 } }
        expect(response.response_code).to eq(201)

        parsed_body = JSON.parse(response.body)
        
        expect(parsed_body).to eq("journey" => "{\"journey\":[[\"A\",\"C\"],[\"C\",\"B\"]],\"cost\":7.5}")
      end
    end
  end
end
