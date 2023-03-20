FactoryBot.define do
    factory :user do
      email { "user@example.com" }
      password { "password123" }
      confirmed_at { Time.now }
      organization
  
      trait :admin do
        role { "admin" }
      end
    end
  end
  