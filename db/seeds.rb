User.create([{ username: 'Steve123', email: 'steve@gmail.com',
               first_name: 'Steve', last_name: 'Rot',
               password: '12341234', password_confirmation: '12341234' },
             { username: 'Brad123', email: 'brad@gmail.com',
                first_name: 'Brad', last_name: 'Pit',
                password: '12341234', password_confirmation: '12341234' },
             { username: 'John123', email: 'john@gmail.com',
                first_name: 'John', last_name: 'Buschemi',
                password: '12341234', password_confirmation: '12341234' }])

User.first.meal_recipes.create({ title: 'First Recipe',
                                 description: 'This first recipe is about making a first recipe' })

User.second.meal_recipes.create({ title: 'Second Recipe',
                                  description: 'This second recipe is about making a second recipe' })

User.third.meal_recipes.create({ title: 'Last Recipe',
                                 description: 'This second recipe is about making a second recipe' })

MealRecipe.first.recipe_instructions.create({ instruction: "first make the instruction 1" })
MealRecipe.first.recipe_instructions.create({ instruction: "second make the instruction 2" })

MealRecipe.second.recipe_instructions.create({ instruction: "first make the instruction 1" })
MealRecipe.second.recipe_instructions.create({ instruction: "second make the instruction 2" })

MealRecipe.third.recipe_instructions.create({ instruction: "first make the instruction 1" })
MealRecipe.third.recipe_instructions.create({ instruction: "second make the instruction 2" })

MealRecipe.first.recipe_ingredients.create({ ingredient: "first make the ingredient 1" })
MealRecipe.first.recipe_ingredients.create({ ingredient: "second make the ingredient 2" })

MealRecipe.second.recipe_ingredients.create({ ingredient: "first make the ingredient 1" })
MealRecipe.second.recipe_ingredients.create({ ingredient: "second make the ingredient 2" })

MealRecipe.third.recipe_ingredients.create({ ingredient: "first make the ingredient 1" })
MealRecipe.third.recipe_ingredients.create({ ingredient: "second make the ingredient 2" })
