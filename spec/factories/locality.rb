require 'factory_girl'
require 'forgery'

FactoryGirl.define do
  factory :locality do
    name { Forgery('name').first_name }
  end
end
