class RecipeIngredient < ApplicationRecord
  belongs_to :meal_recipe

  validates :ingredient, presence: true
end
