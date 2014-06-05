class Recipe
  attr_reader :name, :id, :description, :instructions, :ingredients
  def initialize(recipe)
    @name = recipe['name']
    @id = recipe['id']
    @description = recipe['description']
    @instructions = recipe['instructions']
    @ingredients = recipe['ingredients']
  end

  def self.all

    connection = PG.connect(dbname: 'recipes')
    results= connection.exec('SELECT * FROM recipes ORDER BY name')
    connection.close

    @recipes = []

    results.each do |recipe|
      @recipes << Recipe.new(recipe)
    end
    @recipes
  end

  def self.find(params)
    a_recipe = nil
    @recipes.each do |recipe|
      if recipe.id == params
        a_recipe = recipe
      end
    end
    a_recipe
  end

  def ingredients

     @ingredients = Ingredient.find_ingredients(id)
  end

end
