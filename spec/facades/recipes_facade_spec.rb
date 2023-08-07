require 'rails_helper'

RSpec.describe RecipesFacade do
  describe 'Recipe' do
    describe '#search' do
      it 'can return recipes as objects'do
        country = {country: 'thailand'}

        recipes = RecipesFacade.new(country).search

        expect(recipes).to be_an Array

        recipes.each do |recipe|
          expect(recipe).to be_a Recipe
          expect(recipe.id).to eq("null")
          expect(recipe.title).to be_a String
          expect(recipe.url).to be_a String
          expect(recipe.country).to be_a String
          expect(recipe.image).to be_a String
        end
      end

      it 'can return an empty array if no hits'do
        country = {country: ' '}

        recipes = RecipesFacade.new(country).search

        expect(recipes).to be_an Array
        expect(recipes).to eq([])
      end
    end
  end
end