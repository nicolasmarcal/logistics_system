require "spec_helper"

RSpec.describe JourneyMaker, :type => :module do
  it { should validate_presence_of(:origin) }
  it { should validate_presence_of(:destiny) }
  it { should validate_presence_of(:truck_autonomy) }
  it { should validate_presence_of(:liter_price) }
end