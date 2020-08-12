class AddUserToRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipe_ingredients, :user, foreign_key: true
  end
end
