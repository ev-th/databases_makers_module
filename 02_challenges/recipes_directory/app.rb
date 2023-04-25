require_relative "lib/database_connection"
require_relative "lib/recipe_repository"

DatabaseConnection.connect("recipes_directory")

recipe_repository = RecipeRepository.new

recipes = recipe_repository.all

recipes.each { |recipe| p recipe.name }
