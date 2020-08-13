class RecipeInstructionsController < ApplicationController
  def new
    @meal_recipe = MealRecipe.find(params[:meal_recipe_id])
    @recipe_instruction = @meal_recipe.recipe_instructions.build
  end

  def create
    @meal_recipe = MealRecipe.find(params[:meal_recipe_id])
    @recipe_instruction = @meal_recipe.recipe_instructions.build(recipe_instruction_params)

    if @recipe_instruction.save
      redirect_to @meal_recipe
    else
      render :new
    end
  end

  def edit
    @recipe_instruction = RecipeInstruction.find(params[:id])
    @meal_recipe = @recipe_instruction.meal_recipe
  end

  def update
    @recipe_instruction = RecipeInstruction.find(params[:id])
    @meal_recipe = @recipe_instruction.meal_recipe

    if @recipe_instruction.update recipe_instruction_params
      redirect_to @meal_recipe
    else
      render :edit
    end
  end

  def destroy
    recipe_instruction = RecipeInstruction.find(params[:id])
    @meal_recipe = recipe_instruction.meal_recipe

    recipe_instruction.destroy
    redirect_to @meal_recipe
  end

  private

  def recipe_instruction_params
    params.require(:recipe_instruction).permit(:instruction)
  end
end
