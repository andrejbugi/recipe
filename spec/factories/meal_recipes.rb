FactoryBot.define do
  factory :meal_recipe do
    user
    title { 'Recipe Title' }
    description { 'The description must be at least 32 char' }
  end
end
