
class Ingredient
  attr_reader :name, :recipe_id, :id
  def initialize(ingredient)
    @name = ingredient['name']
    @recipe_id= ingredient['recipe_id']
    @id = ingredient['id']
  end

  def self.find_ingredients(recipe_id)
    connection = PG.connect(dbname: 'recipes')
    query = connection.exec_params('SELECT * FROM ingredients WHERE recipe_id = $1', [recipe_id])
    connection.close

    ingredients = []

    query.each do |ingredient|
      ingredients << Ingredient.new(ingredient)
    end
    ingredients
  end
end
