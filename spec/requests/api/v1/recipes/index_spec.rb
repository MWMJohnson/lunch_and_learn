require 'rails_helper'

RSpec.describe 'Recipes' do
  describe 'GET api_v1_recipes_path' do 
    describe "By Search" do
      describe "happy paths" do
        it "can get recipes by search" do
          get api_v1_recipes_path(country: 'thailand')

          expect(response).to be_successful
          
          result = JSON.parse(response.body, symbolize_names: true)
          
          recipes = result[:data]

          expect(recipes).to be_an Array
          expect(recipes.first).to be_a Hash

          recipes.each do |recipe|
            expect(recipe).to have_key(:id)
            expect(recipe[:id]).to eq("null")

            expect(recipe).to have_key(:type)
            expect(recipe[:type]).to eq('recipe')

            expect(recipe).to have_key(:attributes)
            expect(recipe[:attributes]).to be_a Hash

            expect(recipe[:attributes]).to have_key(:title)
            expect(recipe[:attributes][:title]).to be_a String

            expect(recipe[:attributes]).to have_key(:url)
            expect(recipe[:attributes][:url]).to be_a String

            expect(recipe[:attributes]).to have_key(:country)
            expect(recipe[:attributes][:country]).to be_a String

            expect(recipe[:attributes]).to have_key(:image)
            expect(recipe[:attributes][:image]).to be_a String
          end

          result = recipes.first[:attributes]

          expect(result[:title]).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
          expect(result[:url]).to eq("http://www.edamam.com/ontologies/edamam.owl#recipe_3a551652abf5a1cef1421660d1b657d9")
          expect(result[:country]).to eq("thailand")
          expect(result[:image].first(100)).to eq("https://edamam-product-images.s3.amazonaws.com/web-img/611/61165abc1c1c6a185fe5e67167d3e1f0.jpg?X-Am")
        end

        it "returns a random countries recipes if no country is given" do
          get api_v1_recipes_path

          expect(response).to be_successful
          
          results = JSON.parse(response.body, symbolize_names: true)
          
          recipes = results[:data]

          expect(recipes).to be_an Array
          expect(recipes.first).to be_a Hash

          recipes.each do |recipe|
            expect(recipe).to have_key(:id)
            expect(recipe[:id]).to eq("null")

            expect(recipe).to have_key(:type)
            expect(recipe[:type]).to eq('recipe')

            expect(recipe).to have_key(:attributes)
            expect(recipe[:attributes]).to be_a Hash

            expect(recipe[:attributes]).to have_key(:title)
            expect(recipe[:attributes][:title]).to be_a String

            expect(recipe[:attributes]).to have_key(:url)
            expect(recipe[:attributes][:url]).to be_a String

            expect(recipe[:attributes]).to have_key(:country)
            expect(recipe[:attributes][:country]).to be_a String

            expect(recipe[:attributes]).to have_key(:image)
            expect(recipe[:attributes][:image]).to be_a String
          end
        end

        describe 'sad paths' do
          it "return an empty array if no results found for country or empty string given" do
            get api_v1_recipes_path(country: 'fdsfdsfd')

            expect(response).to be_successful
            
            result = JSON.parse(response.body, symbolize_names: true)
            
            recipes = result[:data]

            expect(recipes).to be_an Array
            expect(recipes.empty?).to be true
          end
        end
      end
    end
  end
end