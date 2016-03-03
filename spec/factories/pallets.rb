FactoryGirl.define do
  factory :pallet do
    cycle_count
    pallet_number { Faker::Number.number(6) }
    association :created_by, factory: :user, role_name: :cycle_counter
    association :updated_by, factory: :user, role_name: :cycle_counter
  end
end
