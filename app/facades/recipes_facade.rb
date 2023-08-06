class RecipesFacade
  attr_reader :country

  def initialize(params = {})
    @country = params[:country]
  end

  def search
    if @country
      recipe_search(@country)
    else
      random_country_recipes
    end
  end

  def recipe_search(country)
    make_recipes(edamam_service.get_recipes_by_country(country), country)
  end

  def make_recipes(json, country)
    recipes = json[:hits]
    recipes.map do |recipe|
      Recipe.new(recipe, country)
    end
  end

  # def random_country_recipes
  #   service.new.get_random_country
    
  # end

  def edamam_service
    EdamamService.new
  end
end

