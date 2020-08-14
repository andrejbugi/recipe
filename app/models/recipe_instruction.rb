class RecipeInstruction < ApplicationRecord
  belongs_to :meal_recipe

  validates :instruction, presence: true
end
