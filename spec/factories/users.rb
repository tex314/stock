# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.test" }
    password "password"
    password_confirmation "password"
  end
end
