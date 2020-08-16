require 'rails_helper'

RSpec.describe "RecipeIngredients" do
  let(:user) { create(:user) }
  let(:diff_user) { create(:user) }
  let(:meal_recipe) { create(:meal_recipe, user: user) }
  let(:recipe_ingredient) { create(:recipe_ingredient, meal_recipe: meal_recipe) }

  describe 'Recipe ingredient' do
    context 'when creating ingredient' do
      it 'redirects to home page if wrong user' do
        request_log_in(diff_user)

        post_params = {
          params: {
            recipe_ingredient: {
              ingredient: "ingredient 1 patch"
            }
          }
        }

        get "/meal_recipes/#{meal_recipe.id}/recipe_ingredients/new", post_params

        expect(response).to have_http_status(:found)
        follow_redirect!
        expect(response.body).to include('Wrong User')
      end

      it 'redirects to login page when no user' do
        get "/meal_recipes/#{meal_recipe.id}/recipe_ingredients/new"
        
        expect(response).to have_http_status(:found)
        expect(flash[:danger]).to eq 'Please sign in to continue.'
      end
    end

    context 'when editing ingredient' do
      it 'redirects to login page when no user is signed in' do
        get "/meal_recipes/#{meal_recipe.id}/recipe_ingredients/#{recipe_ingredient.id}/edit"
        expect(response).to have_http_status(:found)
        expect(flash[:danger]).to eq 'Please sign in to continue.'
      end

      it 'updates the ingredient if correct user is signed in' do
        request_log_in(user)

        get "/meal_recipes/#{meal_recipe.id}/recipe_ingredients/#{recipe_ingredient.id}/edit"
        expect(response).to have_http_status(:ok)

        patch_params = {
          params: {
            recipe_ingredient: {
              ingredient: "ingredient 1 patch"
            }
          }
        }

        patch "/meal_recipes/#{meal_recipe.id}/recipe_ingredients/#{recipe_ingredient.id}", patch_params

        expect(response).to have_http_status(:found)
        follow_redirect!
        expect(response.body).to include("ingredient 1 patch")
      end

      it 'redirects to home page if different user is logged in' do
        request_log_in(diff_user)

        patch_params = {
          params: {
            recipe_ingredient: {
              ingredient: "ingredient 1 patch"
            }
          }
        }

        patch "/meal_recipes/#{meal_recipe.id}/recipe_ingredients/#{recipe_ingredient.id}", patch_params

        expect(response).to have_http_status(:found)
        follow_redirect!
        expect(response.body).to include('Wrong User')
      end
    end

    context 'when deleting an ingredient' do
      it 'deletes the ingredient if correct user is signed in' do
        request_log_in(user)

        delete "/meal_recipes/#{meal_recipe.id}/recipe_ingredients/#{recipe_ingredient.id}"

        expect(response).to redirect_to(meal_recipe)
      end

      it 'redirects to login page when no user is signed in' do
        delete "/meal_recipes/#{meal_recipe.id}/recipe_ingredients/#{recipe_ingredient.id}"

        expect(response).to have_http_status(:found)
        expect(flash[:danger]).to eq 'Please sign in to continue.'
      end

      it 'redirects to home page if different user is logged in' do
        request_log_in(diff_user)

        delete "/meal_recipes/#{meal_recipe.id}/recipe_ingredients/#{recipe_ingredient.id}"

        expect(response).to have_http_status(:found)
        follow_redirect!
        expect(response.body).to include('Wrong User')
      end
    end
  end
end
