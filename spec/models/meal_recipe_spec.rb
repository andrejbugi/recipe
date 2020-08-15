require 'rails_helper'

RSpec.describe MealRecipe do
  describe 'associations' do
    it { is_expected.to have_many(:recipe_instructions) }
    it { is_expected.to have_many(:recipe_ingredients) }
    it { is_expected.to belong_to(:user) }

    describe 'dependency' do
      let(:recipe_instructions_count) { 1 }
      let(:recipe_ingredients_count) { 1 }
      let(:meal_recipe) { create(:meal_recipe) }

      it 'destroys recipe_instructions' do
        create_list(:recipe_instruction, recipe_instructions_count, meal_recipe: meal_recipe)

        expect { meal_recipe.destroy }.to change { RecipeInstruction.count }.by(-recipe_instructions_count)
      end

      it 'destroys recipe_ingredients' do
        create_list(:recipe_ingredient, recipe_ingredients_count, meal_recipe: meal_recipe)

        expect { meal_recipe.destroy }.to change { RecipeIngredient.count }.by(-recipe_ingredients_count)
      end

    end

    it { is_expected.to accept_nested_attributes_for(:recipe_instructions).allow_destroy(true) }
    it { is_expected.to accept_nested_attributes_for(:recipe_ingredients).allow_destroy(true) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }

    it { is_expected.to validate_length_of(:title).is_at_most(MealRecipe::MAXIMUM_TITLE_LENGTH) }
    it { is_expected.to validate_length_of(:description).is_at_least(MealRecipe::MINIMUM_DESCRIPTION_LENGTH) }
    it { is_expected.to validate_length_of(:description).is_at_most(MealRecipe::MAXIMUM_DESCRIPTION_LENGTH) }
  end

end

