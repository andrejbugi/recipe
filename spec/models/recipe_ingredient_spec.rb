require 'rails_helper'

RSpec.describe RecipeIngredient do
  describe 'associations' do
    it { is_expected.to belong_to(:meal_recipe) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:ingredient) }
  end
end
