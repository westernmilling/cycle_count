FactoryGirl.define do
  factory :location do
    location_number { Faker::Number.number(6) }
    area_number { Faker::Number.number(6) }
    sequence_number { Faker::Number.number(6) }
    sequence(:description) { |n| "#{Faker::Commerce.product_name} #{n}" }
    association :created_by, factory: :user, role_name: :cycle_counter
    association :updated_by, factory: :user, role_name: :cycle_counter
  end
end
