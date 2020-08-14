FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testing#{n}@test.com" }
    username { 'brad123'}
    first_name { 'Brad' }
    last_name { 'Pit' }
    password { '12341234' }
    password_confirmation { '12341234' }
  end
end
