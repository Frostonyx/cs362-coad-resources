FactoryBot.define do
  factory :ticket do
    name { "Example Ticket" }
    phone { "123-456-7890" }
    description { "This is an example ticket" }
    region { association :region }
    resource_category { association :resource_category }
    organization { association :organization }

    trait :open do
      closed { false }
      organization { nil }
    end

    trait :closed do
      closed { true }
    end
  end
end
