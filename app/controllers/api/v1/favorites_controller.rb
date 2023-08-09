class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user 
      user.favorites.create!(favorite_params)
      render json: { "success": "Favorite added successfully" }, status: 201
    else
      render json: { "error": "Unauthorized to add this recipe as a favorite" }, status: 401
    end
  end

  private

  def favorite_params
    params.permit(:recipe_title, :recipe_link, :country)
  end
end