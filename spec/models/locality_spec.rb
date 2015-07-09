require "spec_helper"

RSpec.describe Locality, :type => :model do
  subject { FactoryGirl.build(:locality) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it "has a valid factory" do
    expect(subject).to be_valid
  end
end