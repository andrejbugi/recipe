require 'rails_helper'

RSpec.describe "HomePages", type: :system do
  before do
    driven_by :rack_test

    # Capybara.server = :puma, { Silent: true }
  end

  it 'shows the home button link' do
    visit root_path
    link = page.has_link?('All Recipes')
    expect(link).to be true
  end

  it 'shows footer' do
    visit root_path
    text = page.has_text?('2020 All Rights Reserved Andrej')
    expect(text).to be true
  end

  context 'when no user is signed in' do
    it 'shows the Sign in link' do
      visit root_path
      link = page.has_link?('Sign In')
      expect(link).to be true
    end

    it 'shows the Sign up link' do
      visit root_path
      link = page.has_link?('Sign Up')
      expect(link).to be true
    end

    context 'when there is a recipe' do
      it 'shows the recipe header' do
        create(:meal_recipe)

        visit root_path

        text = page.has_text?('Recipe by:')
        expect(text).to be true
      end

      it 'shows the recipe title' do
        meal_recipe = create(:meal_recipe)

        visit root_path

        text = page.has_text?(meal_recipe.title)
        expect(text).to be true
      end

      it 'shows the recipe description' do
        meal_recipe = create(:meal_recipe)

        visit root_path

        text = page.has_text?(meal_recipe.description)
        expect(text).to be true
      end

      it 'shows the recipe user' do
        meal_recipe = create(:meal_recipe)

        visit root_path

        link = page.has_link?(meal_recipe.user.first_name)

        expect(link).to be true
      end

      it 'has Show recipe link' do
        create(:meal_recipe)

        visit root_path

        link = page.has_link?('Show')
        expect(link).to be true
      end
    end
  end

  context 'when user is signed in' do
    before do
      log_in(create(:user))

      visit root_path
    end

    it 'shows the New Recipe link' do
      link = page.has_link?('New Recipe')
      expect(link).to be true
    end

    it 'shows the Log Out link' do
      link = page.has_link?('Log Out')
      expect(link).to be true
    end

    it 'shows the My Profile link' do
      link = page.has_link?('My Profile')
      expect(link).to be true
    end
  end

  context 'when user is signed in and has recipes' do
    it 'has Edit recipe link' do
      user = create(:user)

      visit login_path

      within('form') do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password

        click_on 'Sign In'
      end

      visit root_path

      create(:meal_recipe, user: user)

      visit root_path

      link = page.has_link?('Edit')
      expect(link).to be true
    end

    it 'has Delete recipe link' do
      user = create(:user)

      visit login_path

      within('form') do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password

        click_on 'Sign In'
      end

      visit root_path

      create(:meal_recipe, user: user)

      visit root_path

      link = page.has_link?('Delete')
      expect(link).to be true
    end
  end
end
