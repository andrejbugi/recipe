require 'rails_helper'

RSpec.describe "RecipeInteractions", type: :system do

  let(:user) { create(:user) }
  let(:meal_recipe) { create(:meal_recipe, user: user) }

  before do
    driven_by(:rack_test)

    log_in(user)
  end

  it 'shows the user' do
    expect(user).to be_present
  end


  describe 'Creating Recipe' do
    it 'creates and shows the new Recipe' do
      title = 'Recipe '
      description = 'This is the description for the new recipe..'
      instruction = 'instruction 1'
      ingredient = 'ingredient 1'

      click_on('New Recipe')

      within('form') do
        fill_in 'Title', with: title
        fill_in 'Description', with: description
        fill_in 'meal_recipe[recipe_instructions_attributes][0][instruction]', with: instruction
        fill_in 'meal_recipe[recipe_ingredients_attributes][0][ingredient]', with: ingredient

        click_on 'Create Recipe'
      end

      expect(page).to have_content(title)
      expect(page).to have_content(description)
      expect(page).to have_content(instruction)
      expect(page).to have_content(ingredient)
    end
  end

  describe 'Editing Recipe' do
    it 'edits and shows the recipe' do
      title = 'Recipe '
      description = 'This is the description for the new recipe..'

      visit meal_recipe_path(meal_recipe)

      click_on 'Edit'

      within('form') do
        fill_in "Title", with: title
        fill_in "Description", with: description

        click_on 'Update Recipe'
      end

      expect(page).to have_content(title)
      expect(page).to have_content(description)
    end
  end

  describe 'Deleting recipe' do
    it 'deletes the recipe and redirects to home page' do
      visit meal_recipe_path(meal_recipe)

      click_on 'Delete'

      expect(page).to have_content('All Recipes')
    end
  end

  describe 'Going back to recipes home page' do
    it 'goes back to home page' do
      visit meal_recipe_path(meal_recipe)

      click_on 'Home'

      expect(page).to have_content('All Recipes')
    end
  end

  describe 'Showing the ingredients and instructions' do
    context 'when on recipe page' do
      it 'shows the instructions' do
        visit meal_recipe_path(meal_recipe)

        expect(page).to have_content 'Instructions:'
      end

      it 'shows the ingredients' do
        visit meal_recipe_path(meal_recipe)

        expect(page).to have_content 'Ingredients:'
      end
    end
  end

  describe 'Adding instruction/ingredient' do
    context 'when additionally adding new instruction' do
      it 'adds instruction' do
        instruction = 'instruction 123'
        visit meal_recipe_path(meal_recipe)

        click_on 'Add instruction'

        within('form') do
          fill_in 'recipe_instruction[instruction]', with: instruction
        end

        click_on 'Add Instruction'

        expect(page).to have_content instruction
      end
    end

    context 'when additionally adding new ingredient' do
      it 'adds ingredient' do
        ingredient = 'ingredient 123'
        visit meal_recipe_path(meal_recipe)

        click_on 'Add ingredient'

        within('form') do
          fill_in 'recipe_ingredient[ingredient]', with: ingredient
        end
        click_on 'Add Ingredient'

        expect(page).to have_content ingredient
      end
    end
  end

end
