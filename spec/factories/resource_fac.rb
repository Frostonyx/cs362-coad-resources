FactoryBot.define do
    factory :resource_category do
      sequence(:name) { |n| "Category #{n}" }
      active { true }
  
      trait :inactive do
        active { false }
      end
    end
  end
  