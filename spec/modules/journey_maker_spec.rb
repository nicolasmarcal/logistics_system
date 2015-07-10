require "spec_helper"

RSpec.describe JourneyMaker, :type => :module do
  it { should validate_presence_of(:origin) }
  it { should validate_presence_of(:destiny) }
  it { should validate_presence_of(:truck_autonomy) }
  it { should validate_presence_of(:liter_price) }

  describe ".route" do
    let!(:locality_a){ FactoryGirl.create(:locality, :name => "A") }
    let!(:locality_b){ FactoryGirl.create(:locality, :name => "B") }
    let!(:locality_c){ FactoryGirl.create(:locality, :name => "C") }
    let!(:locality_d){ FactoryGirl.create(:locality, :name => "D") }
  
    let!(:route_one){ FactoryGirl.create(:route, :origin_locality => locality_a, :destination_locality => locality_c, :distance => 10) }
    let!(:route_two){ FactoryGirl.create(:route, :origin_locality => locality_a, :destination_locality => locality_b, :distance => 50) }
    let!(:route_tree){ FactoryGirl.create(:route, :origin_locality => locality_c, :destination_locality => locality_b, :distance => 20) }
    let!(:route_four){ FactoryGirl.create(:route, :origin_locality => locality_c, :destination_locality => locality_d, :distance => 50) }
    let!(:route_five){ FactoryGirl.create(:route, :origin_locality => locality_d, :destination_locality => locality_b, :distance => 100) }
    
    context "find the cheap route" do
      subject{ JourneyMaker.new(:origin_name => "A", :destiny_name => "B", :truck_autonomy => 10.0, :liter_price => 2.5) }
      let(:response){
        { :journey => [["A", "C"], ["C", "B"]], :cost => 7.5 }
      }

      it "return the cheap route" do
        expect(subject).to be_valid

        expect(subject.route).to eq(response)
      end
    end
  end
end