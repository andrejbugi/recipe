class RecipeInstructionsController < ApplicationController
  before_action :find_recipe_instruction, only: %i[edit update destroy]
  before_action :find_meal_recipe, only: %i[edit update destroy]

  def new
    @meal_recipe = MealRecipe.find(params[:meal_recipe_id])
    @recipe_instruction = @meal_recipe.recipe_instructions.build

    check_current_user(@meal_recipe.user) and return
  end

  def create
    @meal_recipe = MealRecipe.find(params[:meal_recipe_id])
    @recipe_instruction = @meal_recipe.recipe_instructions.build(recipe_instruction_params)

    check_current_user(@meal_recipe.user) and return

    if @recipe_instruction.save
      redirect_to @meal_recipe
    else
      render :new
    end
  end

  def edit
    check_current_user(@meal_recipe.user)
  end

  def update
    check_current_user(@meal_recipe.user) and return

    if @recipe_instruction.update recipe_instruction_params
      redirect_to @meal_recipe and return
    else
      render :edit
    end
  end

  def destroy
    check_current_user(@meal_recipe.user) and return

    @recipe_instruction.destroy

    redirect_to(@meal_recipe)
  end

  private

  def recipe_instruction_params
    params.require(:recipe_instruction).permit(:instruction)
  end

  def find_recipe_instruction
    @recipe_instruction = RecipeInstruction.find(params[:id])
  end

  def find_meal_recipe
    @meal_recipe = @recipe_instruction.meal_recipe
  end
end
