FactoryGirl.define do
  factory :location do
    location_number { Faker::Number.number(6) }
    area_number { Faker::Number.number(6) }
    sequence_number { Faker::Number.number(6) }
    description { Faker::Commerce.product_name }
    association :created_by, factory: :user, role_name: :cycle_counter
    association :updated_by, factory: :user, role_name: :cycle_counter
  end
end
