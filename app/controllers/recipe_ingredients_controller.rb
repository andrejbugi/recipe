class RecipeIngredientsController < ApplicationController
  def new
    @meal_recipe = MealRecipe.find(params[:meal_recipe_id])
    @recipe_ingredient = @meal_recipe.recipe_ingredients.build
  end

  def create
    @meal_recipe = MealRecipe.find(params[:meal_recipe_id])
    @recipe_ingredient = @meal_recipe.recipe_ingredients.build(recipe_ingredient_params)
    @recipe_ingredient.user = @current_user

    if @recipe_ingredient.save
      redirect_to @meal_recipe
    else
      render :new
    end
  end

  def edit
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @meal_recipe = @recipe_ingredient.meal_recipe
  end

  def update
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @meal_recipe = @recipe_ingredient.meal_recipe
    # @recipe_ingredient.user = @current_user

    if @recipe_ingredient.update recipe_ingredient_params
      redirect_to @meal_recipe
    else
      render :edit
    end
  end

  def destroy
    recipe_ingredient = RecipeIngredient.find(params[:id])
    @meal_recipe = recipe_ingredient.meal_recipe

    recipe_ingredient.destroy
    redirect_to @meal_recipe
  end

  private

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:ingredient)
  end
end
