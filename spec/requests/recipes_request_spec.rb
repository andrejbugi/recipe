require 'rails_helper'

RSpec.describe "Recipes" do
  describe 'Creating Recipe' do
    context 'when no user is logged in' do
      it 'redirects back to login path' do
        post_params = {
          params: {
            meal_recipe: {
              title: 'New Recipe',
              description: 'description is needed for the recipe creation'
            }
          }
        }

        post '/meal_recipes', post_params

        expect(response).to redirect_to(login_path)
        expect(flash[:danger]).to eq 'Please sign in to continue.'
      end
    end
  end

  describe 'Editing Recipe' do
    context "when the recipe's user is the same as the logged in user" do
      let(:user) { create(:user) }
      let(:meal_recipe) { create(:meal_recipe, user: user) }

      it 'can edit the recipe' do
        get '/login'
        expect(response).to have_http_status(:ok)

        request_log_in(user)

        follow_redirect!

        expect(flash[:success]).to eq "Successfully logged in!"

        get "/meal_recipes/#{meal_recipe.id}"
        expect(response).to have_http_status(:ok)

        get "/meal_recipes/#{meal_recipe.id}/edit"
        expect(response).to have_http_status(:ok)

        patch_params = {
          params: {
            meal_recipe: {
              title: meal_recipe.title,
              description: "description is needed for the recipe creation"
            }
          }
        }

        patch "/meal_recipes/#{meal_recipe.id}", patch_params

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(assigns(:meal_recipe))
        follow_redirect!
        expect(response.body).to include(meal_recipe.title)
      end
    end

    context "when the recipe user is different then the logged in user" do
      let(:user) { create(:user) }
      let(:meal_recipe) { create(:meal_recipe, user: user) }

      let(:diff_user) { create(:user) }

      before { request_log_in(diff_user) }

      it 'redirect back when GET edit' do
        get "/meal_recipes/#{meal_recipe.id}/edit"

        expect(flash[:danger]).to eq 'Wrong User'
        expect(response).to redirect_to(root_path)
      end

      it 'redirect back when PATCH edit' do
        patch_params = {
          params: {
            meal_recipe: {
              title: meal_recipe.title,
              description: "description is needed for the recipe creation"
            }
          }
        }

        patch "/meal_recipes/#{meal_recipe.id}", patch_params

        expect(flash[:danger]).to eq 'Wrong User'
        expect(response).to redirect_to(root_path)
      end
    end

    context "when no user is logged in" do
      let(:meal_recipe) { create(:meal_recipe) }

      it 'redirect back to root path' do
        get "/meal_recipes/#{meal_recipe.id}/edit"

        expect(flash[:danger]).to eq 'Please sign in to continue.'
        expect(response).to redirect_to(login_path)
      end

      it 'redirect back to home page when updating recipe' do
        patch_params = {
          params: {
            meal_recipe: {
              title: meal_recipe.title,
              description: "description is needed for the recipe creation"
            }
          }
        }

        patch "/meal_recipes/#{meal_recipe.id}", patch_params

        expect(flash[:danger]).to eq 'Please sign in to continue.'
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'Deleting recipe' do
    context "when the recipe user is the same as the logged in User" do
      let(:user) { create(:user) }
      let(:meal_recipe) { create(:meal_recipe, user: user) }

      it 'can delete the meal_recipe' do
        request_log_in(user)

        delete "/meal_recipes/#{meal_recipe.id}"

        expect(response).to redirect_to(meal_recipes_path)
      end
    end

    context "when the meal_recipe's user is different then the logged in User" do
      let(:user) { create(:user) }
      let(:meal_recipe) { create(:meal_recipe, user: user) }

      let(:diff_user) { create(:user) }

      it 'redirect back to root path' do
        request_log_in(diff_user)

        delete "/meal_recipes/#{meal_recipe.id}"

        expect(flash[:danger]).to eq 'Wrong User'
        expect(response).to redirect_to(root_path)
      end
    end

    context "when no user is logged in" do
      let(:meal_recipe) { create(:meal_recipe) }

      it 'redirect back to root path' do
        delete "/meal_recipes/#{meal_recipe.id}"

        expect(flash[:danger]).to eq 'Please sign in to continue.'
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
