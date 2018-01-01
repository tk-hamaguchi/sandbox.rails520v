FactoryBot.define do
  factory :user do
    name { generate :user_name }
    email { generate :email }
    password { generate :password }
    association :tenant

    factory :confirmed_user do
      confirmed_at { Time.zone.now }
    end
  end
end
