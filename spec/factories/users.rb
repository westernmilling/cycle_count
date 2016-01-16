FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :admin do
      role_name 'admin'
    end

    trait :cycle_counter do
      role_name 'cycle_counter'
    end

    trait :moderator do
      role_name 'moderator'
    end
  end
end
