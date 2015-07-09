require "spec_helper"

RSpec.describe Route, :type => :model do
  subject { FactoryGirl.build(:route) }

  it { should validate_presence_of(:distance) }
  it { should validate_presence_of(:origin_locality_id) }
  it { should validate_presence_of(:destination_locality_id) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end
end