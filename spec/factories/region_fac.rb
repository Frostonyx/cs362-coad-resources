FactoryBot.define do
    factory :region do
      sequence(:name) { |n| "Region #{n}" }
  
      trait :unspecified do
        name { "Unspecified" }
      end
    end
  end
  