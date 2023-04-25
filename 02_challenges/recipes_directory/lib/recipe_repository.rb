require_relative "./recipe"

class RecipeRepository
  def all
    sql = "SELECT id, name, average_cooking_time_minutes, rating_out_of_five FROM recipes;"
    records = DatabaseConnection.exec_params(sql, [])

    recipes = []

    records.each do |record|
      recipe = Recipe.new
      recipe.id = record["id"]
      recipe.name = record["name"]
      recipe.average_cooking_time_minutes = record["average_cooking_time_minutes"]
      recipe.rating_out_of_five = record["rating_out_of_five"]

      recipes << recipe
    end
    return recipes
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    sql = "SELECT id, name, average_cooking_time_minutes, rating_out_of_five
    FROM recipes
    WHERE id = $1;"
    params = [id]
    records = DatabaseConnection.exec_params(sql, params)
    record = records[0]

    recipe = Recipe.new
    recipe.id = record["id"]
    recipe.name = record["name"]
    recipe.average_cooking_time_minutes = record["average_cooking_time_minutes"]
    recipe.rating_out_of_five = record["rating_out_of_five"]

    recipe
  end
end