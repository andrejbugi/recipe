class MealRecipe < ApplicationRecord
  MAXIMUM_TITLE_LENGTH = 64
  MAXIMUM_DESCRIPTION_LENGTH = 512
  MINIMUM_DESCRIPTION_LENGTH = 32

  validates :title, presence: true, length: { maximum: MAXIMUM_TITLE_LENGTH }
  validates :description, presence: true, length: { minimum: MINIMUM_DESCRIPTION_LENGTH,
                                                    maximum: MAXIMUM_DESCRIPTION_LENGTH }

  belongs_to :user
  has_many :recipe_instructions,
           inverse_of: :meal_recipe,
           dependent: :destroy
  accepts_nested_attributes_for :recipe_instructions,
                                allow_destroy: true,
                                reject_if: lambda { |attributes| attributes['instruction'].blank? }
end
