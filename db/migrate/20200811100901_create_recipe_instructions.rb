class CreateRecipeInstructions < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_instructions do |t|
      t.text :instruction
      t.text :ingredient
      t.references :meal_recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
