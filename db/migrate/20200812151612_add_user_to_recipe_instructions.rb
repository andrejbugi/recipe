class AddUserToRecipeInstructions < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipe_instructions, :user, foreign_key: true
  end
end
