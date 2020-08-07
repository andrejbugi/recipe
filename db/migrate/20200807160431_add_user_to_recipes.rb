class AddUserToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_reference :meal_recipes, :user, foreign_key: true
  end
end
