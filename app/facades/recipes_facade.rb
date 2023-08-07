class RecipesFacade
  attr_reader :country

  def initialize(params = {})
    @country = params[:country]
  end

  def search
    if @country
      recipe_search(@country)
    elsif
      random_country_recipes
      random_country = @country[:name][:common]
      recipe_search(random_country)
    end
  end

  def recipe_search(country)
    make_recipes(recipe_service.get_recipes_by_country(country), country)
  end

  def make_recipes(json, country)
    recipes = json[:hits]
    recipes.map do |recipe|
      Recipe.new(recipe, country)
    end
  end

  def random_country_recipes
    @country = country_service.pick_random_country
  end

  def country_service
    CountryService.new
  end

  def recipe_service
    RecipeService.new
  end
end

