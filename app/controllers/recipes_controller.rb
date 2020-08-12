class RecipesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @meal_recipes = MealRecipe.all
  end

  def show
    @meal_recipe = MealRecipe.find(params[:id])
  end

  def new
    @meal_recipe = MealRecipe.new
    4.times { @meal_recipe.recipe_instructions.build }
    5.times { @meal_recipe.recipe_ingredients.build }
  end

  def create
    @meal_recipe = MealRecipe.new(recipe_params)
    @meal_recipe.user = @current_user

    if @meal_recipe.save
      redirect_to meal_recipe_path(@meal_recipe), notice: "Recipe Created!"
    else
      render :new
    end
  end

  def edit
    @meal_recipe = MealRecipe.find(params[:id])
    2.times { @meal_recipe.recipe_instructions.build }
    2.times { @meal_recipe.recipe_ingredients.build }
  end

  def update
    @meal_recipe = MealRecipe.find(params[:id])

    if @meal_recipe.update(recipe_params)
      redirect_to meal_recipe_path(@meal_recipe)
    else
      render :edit
    end
  end

  def destroy
    meal_recipe = MealRecipe.find(params[:id])
    meal_recipe.destroy
    redirect_to meal_recipes_path, notice: "Recipe Deleted"
  end

  private

  def recipe_params
    params.require(:meal_recipe).permit(:title, :description,
                                        recipe_instructions_attributes:
                                        %i[id instruction _destroy],
                                        recipe_ingredients_attributes:
                                        %i[id ingredient _destroy])
  end
end
