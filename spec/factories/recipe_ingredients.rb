FactoryBot.define do
  factory :recipe_ingredient do
    meal_recipe
    ingredient { 'ingredient for recipe' }
  end
end
