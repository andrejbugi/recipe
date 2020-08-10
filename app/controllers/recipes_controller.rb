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
  end

  def create
    @meal_recipe = MealRecipe.new(recipe_params)
    @meal_recipe.user = @current_user

    if @meal_recipe.save
      redirect_to meal_recipe_path(@meal_recipe), notice: "Recipe Created!"
    else
      @errors = @meal_recipe.errors.full_messages
      render :new
    end
  end

  def edit
    @meal_recipe = MealRecipe.find(params[:id])
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
    redirect_to recipes_path, notice: "Deleted Recipe: #{meal_recipe.title}"
  end

  private

  def recipe_params
    params.require(:meal_recipe).permit(:title, :description)
  end
end
