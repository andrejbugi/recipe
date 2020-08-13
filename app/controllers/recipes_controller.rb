class RecipesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :find_meal_recipe, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @meal_recipes = MealRecipe.all
  end

  def show; end

  def new
    @meal_recipe = MealRecipe.new
    4.times { @meal_recipe.recipe_instructions.build }
    5.times { @meal_recipe.recipe_ingredients.build }
  end

  def create
    @meal_recipe = MealRecipe.new(recipe_params)
    @meal_recipe.user = @current_user

    if @meal_recipe.save
      flash[:success] = 'Recipe Created!'

      redirect_to meal_recipe_path(@meal_recipe)
    else
      render :new
    end
  end

  def edit
    2.times { @meal_recipe.recipe_instructions.build }
    2.times { @meal_recipe.recipe_ingredients.build }
  end

  def update
    if @meal_recipe.update(recipe_params)
      flash[:success] = 'Recipe Saved!'

      redirect_to meal_recipe_path(@meal_recipe)
    else
      render :edit
    end
  end

  def destroy
    @meal_recipe.destroy

    flash[:danger] = 'Recipe Deleted!'

    redirect_to meal_recipes_path
  end

  private

  def recipe_params
    params.require(:meal_recipe).permit(:title, :description,
                                        recipe_instructions_attributes:
                                        %i[id instruction _destroy],
                                        recipe_ingredients_attributes:
                                        %i[id ingredient _destroy])
  end

  def find_meal_recipe
    @meal_recipe = MealRecipe.find(params[:id])
  end

  def correct_user
    unless same_as_current_user?(@meal_recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to root_path and return
    end
  end
end
