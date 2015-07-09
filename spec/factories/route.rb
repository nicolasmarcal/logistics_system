require 'factory_girl'

FactoryGirl.define do
  factory :route do
    distance { Forgery('basic').number }
    origin_locality { FactoryGirl.create(:locality) }
    destination_locality { FactoryGirl.create(:locality) }
  end
end
