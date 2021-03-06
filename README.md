# Recipe

## Recipe it's a modern web application for creating recipes.
## On this web application you can create account and view yours and recipes of all other users out there.

### Authors: Andrej Kostov (andrejbugi96@gmail.com)
### Website: https://github.com/andrejbugi/recipe


# Requirements

- ruby 2.6.5
- rails >= 6.0.3.2
- bcrypt = 3.1.7
- font-awesome-sass = 5.13
- factory_bot_rails

  **In development, test group**

- rspec-rails = 4.0.1

  **In test group**

- capybara
- shoulda-matchers = 4.0
- webdrivers
- rails-controller-testing


# What you can do with Recipe

  We are constantly working and adding new features on Recipe.
  Create new recipes everyday and keep them there for safekeeping.

  **Manage Your Recipes Easy!**

  You can edit your recipes' title, description, ingredients or instructions very simple by just clicking one button.
  Then you only need to change the right content for your recipe.

  **Learn New Recipes**

  You can view other recipes from different users that appear on the Home page.
  Just click show and all the instructions are there.

## Usage and Installation

  Because it's still in development, this is how you can test this application:

  First you need to clone Recipe from GitHub.

  Open your terminal and write:
  - git clone https://github.com/andrejbugi/recipe.git

  It will make a directory called 'recipe' on your hard disk. Go into that directory.

  In the terminal:
  - cd recipe

  Now we need to add all the **gems required**(check requirements).

  Open the TextEditor of your choice and add all the gems into the Gemfile.

  Then run:
  - bundle install

  To use the Database, first you need to install postgresql:

  **follow these instructions for Ubuntu**

    https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04

  **follow these instructions for Mac OSX**

    https://www.codementor.io/@engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb

  **follow these instructions for Windows**

    https://www.microfocus.com/documentation/idol/IDOL_12_0/MediaServer/Guides/html/English/Content/Getting_Started/Configure/_TRN_Set_up_PostgreSQL.htm

  For starting you can seed the database by running:
  - rails db:setup

  then:
  - rails db:seed

  This command will give you some examples for trying out the application.

  **Example users' login info:**
  - brad@gmail.com, pass: 12341234
  - steve@gmail.com, pass: 12341234
  - john@gmail.com, pass: 12341234

  To run the tests, you can write:
  - rspec

  To start the app(server), write the next command in you terminal
  - rails server

  This will start the server, then in the browser go to: localhost:3000

  You should now be able to see the Recipes

  **Have Fun and Make Great Recipes!**
