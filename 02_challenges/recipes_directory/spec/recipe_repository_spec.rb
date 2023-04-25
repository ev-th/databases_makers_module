require "recipe_repository"

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  describe "#all" do
    it "returns an array of Recipe objects" do
      repo = RecipeRepository.new
      recipes = repo.all

      expect(recipes.length).to eq 2

      expect(recipes[0].id).to eq "1"
      expect(recipes[0].name).to eq "recipe_1"
      expect(recipes[0].average_cooking_time_minutes).to eq "30"
      expect(recipes[0].rating_out_of_five).to eq "3"

      expect(recipes[1].id).to eq "2"
      expect(recipes[1].name).to eq "recipe_2"
      expect(recipes[1].average_cooking_time_minutes).to eq "45"
      expect(recipes[1].rating_out_of_five).to eq "5"
    end
  end
  
  describe "#find" do
    it "returns the first record as a Recipe object when passed 1" do
      repo = RecipeRepository.new
      recipe = repo.find(1)
    
      expect(recipe.id).to eq "1"
      expect(recipe.name).to eq "recipe_1"
      expect(recipe.average_cooking_time_minutes).to eq "30"
      expect(recipe.rating_out_of_five).to eq "3"
    end
    
    it "returns the second record as a Recipe object when passed 2" do
      repo = RecipeRepository.new
      recipe = repo.find(2)
    
      expect(recipe.id).to eq "2"
      expect(recipe.name).to eq "recipe_2"
      expect(recipe.average_cooking_time_minutes).to eq "45"
      expect(recipe.rating_out_of_five).to eq "5"
    end
  end
end

