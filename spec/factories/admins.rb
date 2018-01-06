FactoryBot.define do
  factory :admin do
    email    { generate :email    }
    password { generate :password }

    factory :confirmed_admin do
      confirmed_at { Time.zone.now }
    end
  end
end
