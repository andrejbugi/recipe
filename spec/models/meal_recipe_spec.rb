require 'rails_helper'

RSpec.describe MealRecipe do
  describe 'associations' do
    it { is_expected.to have_many(:recipe_instructions) }
    it { is_expected.to have_many(:recipe_ingredients) }
    it { is_expected.to belong_to(:user) }

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

