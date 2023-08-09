require 'rails_helper'

RSpec.describe RecipeService do
  describe "#get_recipes_by_country" do
    it "can receive a country and return recipe results", :vcr do
      country = "thailand"
      search = RecipeService.new.get_recipes_by_country(country)
      expect(search).to have_key(:hits)
      expect(search[:hits]).to be_an Array
      expect(search[:hits].first).to be_a Hash

      recipes = search[:hits]

      recipes.each do |recipe|
        expect(recipe).to have_key(:recipe)
        expect(recipe[:recipe]).to be_a Hash

        expect(recipe[:recipe]).to have_key(:uri)
        expect(recipe[:recipe][:uri]).to be_a String

        expect(recipe[:recipe]).to have_key(:label)
        expect(recipe[:recipe][:label]).to be_a String

        expect(recipe[:recipe]).to_not have_key(:country)

        expect(recipe[:recipe]).to have_key(:image)
        expect(recipe[:recipe][:image]).to be_a String

        expect(recipe[:recipe]).to have_key(:source)
        expect(recipe[:recipe][:source]).to be_a String

        expect(recipe[:recipe]).to have_key(:url)
        expect(recipe[:recipe][:url]).to be_a String

        expect(recipe[:recipe]).to have_key(:dietLabels)
        expect(recipe[:recipe][:dietLabels]).to be_a Array
      end
    end
  end
end