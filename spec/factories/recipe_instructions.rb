FactoryBot.define do
  factory :recipe_instruction do
    meal_recipe
    instruction { 'instruction for recipe' }
  end
end
