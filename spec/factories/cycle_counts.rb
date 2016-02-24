FactoryGirl.define do
  factory :cycle_count do
    location
    requested_date { Faker::Date.forward(30) }
    association :created_by, factory: :user, role_name: :cycle_counter
    association :updated_by, factory: :user, role_name: :cycle_counter
  end
end
