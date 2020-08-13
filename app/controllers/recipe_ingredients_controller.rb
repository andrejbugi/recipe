class RecipeIngredientsController < ApplicationController
  before_action :find_recipe_ingredient, only: %i[edit update destroy]
  before_action :find_meal_recipe, only: %i[edit update destroy]

  def new
    @meal_recipe = MealRecipe.find(params[:meal_recipe_id])
    @recipe_ingredient = @meal_recipe.recipe_ingredients.build
  end

  def create
    @meal_recipe = MealRecipe.find(params[:meal_recipe_id])
    @recipe_ingredient = @meal_recipe.recipe_ingredients.build(recipe_ingredient_params)

    if @recipe_ingredient.save
      redirect_to @meal_recipe
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe_ingredient.update recipe_ingredient_params
      redirect_to @meal_recipe
    else
      render :edit
    end
  end

  def destroy
    @recipe_ingredient.destroy
    redirect_to @meal_recipe
  end

  private

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:ingredient)
  end

  def find_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end

  def find_meal_recipe
    @meal_recipe = @recipe_ingredient.meal_recipe
  end
end
