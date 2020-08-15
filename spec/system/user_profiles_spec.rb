require 'rails_helper'

RSpec.describe "UserProfiles", type: :system do
  before do
    driven_by(:rack_test)

    log_in(create(:user))
  end

  context 'when on user profile page' do
    it 'shows users info' do
      meal_recipe = create(:meal_recipe)

      visit root_path

      click_on "#{meal_recipe.user.first_name}"

      expect(page).to have_content 'User info:'
    end

    it 'shows users recipes' do
      meal_recipe = create(:meal_recipe)

      visit root_path

      click_on "#{meal_recipe.user.first_name}"

      expect(page).to have_content 'Recipes:'
      expect(page).to have_content "#{meal_recipe.title}"
    end
  end
end
