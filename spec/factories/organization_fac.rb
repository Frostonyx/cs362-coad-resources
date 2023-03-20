FactoryBot.define do
    factory :organization do
      name { "Test Organization" }
      email { "test@example.com" }
      phone { "123-456-7890" }
      status { "submitted" }
      primary_name { "John Doe" }
      secondary_name { "Jane Smith" }
      secondary_phone { "987-654-3210" }
      description { "Test description for organization" }
      agreement_one { true }
      agreement_two { true }
      agreement_three { true }
      agreement_four { true }
      agreement_five { true }
      agreement_six { true }
      agreement_seven { true }
      agreement_eight { true }
      
      trait :approved do
        status { "approved" }
      end
      
      trait :rejected do
        status { "rejected" }
      end
      
      trait :with_users do
        after(:create) do |organization|
          create_list(:user, 3, organization: organization)
        end
      end
      
      trait :with_resource_categories do
        after(:create) do |organization|
          create_list(:resource_category, 2, organizations: [organization])
        end
      end
    end
  end
  