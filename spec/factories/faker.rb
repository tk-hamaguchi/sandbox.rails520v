require 'faker'

FactoryBot.define do
  sequence :tenant_name do |n|
    Faker::Company.name
  end
end
