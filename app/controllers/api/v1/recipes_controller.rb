class Api::V1::RecipesController < ApplicationController
  def index
    @facade = RecipesFacade.new(params)
    render json: RecipeSerializer.new(@facade.search)
  end
end