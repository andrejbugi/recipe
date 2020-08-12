class RecipeInstruction < ApplicationRecord
  belongs_to :meal_recipe
  belongs_to :user
end
