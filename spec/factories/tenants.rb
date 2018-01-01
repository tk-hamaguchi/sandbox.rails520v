FactoryBot.define do
  factory :tenant do
    name { generate :tenant_name }
  end
end
