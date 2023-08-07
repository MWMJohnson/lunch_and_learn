require 'rails_helper'

RSpec.describe 'Recipes' do
  describe "Fetch Recipes" do
    describe "By Search" do
      describe "happy paths" do
        it "can get recipes by search" do
          get api_v1_recipes_path(country: 'thailand')

          expect(response).to be_successful
          
          parsed = JSON.parse(response.body, symbolize_names: true)
          
          recipes = parsed[:data]

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
          # expect(result[:image]).to eq("https://edamam-product-images.s3.amazonaws.com/web-img/611/61165abc1c1c6a185fe5e67167d3e1f0.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEM%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJIMEYCIQD2xy7O%2FuMR2Vzkzui77iKv7BUrEVwlcGCd0BwBWFhhjAIhAKpIletr8BwTtVLuta16BWyvDoJ9uE804ZkSNh4n5mPWKrkFCHcQABoMMTg3MDE3MTUwOTg2IgyeVDVeRUccOxjodakqlgVYYjDq8eIC0zZJBX9mB368b3894BdYkLrqkf%2B5lfVwGI0kNl9gd7zIwZrF0wrkY%2BOWKtNaHuGK3SssCvdeCE41%2FezZB%2F8gWgxHoUBWx4EG8cAuAsXT2P%2B6%2FjW1W%2F3Eo%2FxCfZ3IyRNk%2B%2BVzyshZ%2FHzl5EcbSPHIE7R9BbrX%2B9plkia%2FXuyFPSQfA%2FktXkaBcxq8VmvbCosaRjVOdWCcs9XgpKjMV0Al7nsVd%2BLeegQGci6lfAKcNKlTffjjlqBeZFgsSHTIP8WsZSKQRzO17R7pxcZSZW%2BHFwMTQwg6igfZ7S%2FoE1BT5TcNB5rawhBGiN4TXNM13vJ7UBwSugT25LMEtP5yperLbWU6qjEisJQlDpWlacZKFa7MqGEythdTO%2Fy0Rl%2F6j47IrYbty6PCZsXiEsWb1J6IKvdYcqLt4p5QSeByROXfPGJ8bngvMpzfn5lk6MSSZDjKQF8me8OsUvAsWUSc2hhB5Q0mTIEjjtaiCl4Cd2t55XTyZjDL62sFIuRjgtv0ntQ5eU3fU4EFENVVBaLxLexhQhi8NSqXG2%2FrqhdveP7ovPvpRqd33UvjAcckHrEKtnnLu3%2BDpGhdzohv2NYTcw95GOHpoCrYjbPvehJV5knrs7sVK73QsQPTe9wmArXg1mg32ZjWMaeSWe0ecJyP0fsdQ1xjvLP90aMLuSHcNpkM5qkCoFGNFkP8okAx1zL878d9YzihCdFcYCqMqD6%2FVyv%2FwZtf0zMqLhZsmfPpppXGIrkOgH%2BtScepOecF9HJwR7HHw630X58lkRrfH6SPWNcTs87O%2F9kX6BtWUsox6oins78jIL%2F%2BzqtW7JdPjnAnEq7YylMhPow0FY8YZt%2Bw8rdSaeGibfMMI2HBTlhJyn1gQDDv9sOmBjqwAY1HfSCyO90tULeopL4xYXHzKY%2BiHvfVhLHE6uk84%2B71AUATxkmqSTbI%2FrU6zZSZtRfZwZBGD22fL0VFFVx9WGEqFqgzjETPJRYZGzPAjrNcsGdgssgLlkyHUjPp177OrUHBSeNgS55tWmd1gzjiiyU0IzkEOLP1wN8mANx27ga3jgoPIvKwr58F%2FkM0hA1q6ai2IGYKbUBNyVRujzOjQtfy2iQuP7kYFyJg2D2H6aCJ&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230807T145032Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFMO4KPL5C%2F20230807%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=214db92cac8893c5d3cdbba1355ae6331e37117b2404dc00b5c499de82e8125c")
          expect(result[:image].first(100)).to eq("https://edamam-product-images.s3.amazonaws.com/web-img/611/61165abc1c1c6a185fe5e67167d3e1f0.jpg?X-Am")
        end

        # xit "returns a random countries recipes if no country is given", :vcr do
        #   # get api_v1_recipes_path(country: '')

        #   expect(response).to be_successful
          
        #   parsed = JSON.parse(response.body, symbolize_names: true)
          
        #   recipes = parsed[:data]

        #   expect(recipes).to be_an Array
        #   expect(recipes.first).to be_a Hash

        #   recipes.each do |recipe|
        #     expect(recipe).to have_key(:id)
        #     expect(recipe[:id]).to be("null")

        #     expect(recipe).to have_key(:type)
        #     expect(recipe[:type]).to eq('recipe')

        #     expect(recipe).to have_key(:attributes)
        #     expect(recipe[:attributes]).to be_a Hash

        #     expect(recipe[:attributes]).to have_key(:title)
        #     expect(recipe[:attributes][:title]).to be_a String

        #     expect(recipe[:attributes]).to have_key(:url)
        #     expect(recipe[:attributes][:url]).to be_a String

        #     expect(recipe[:attributes]).to have_key(:country)
        #     expect(recipe[:attributes][:country]).to be_a String

        #     expect(recipe[:attributes]).to have_key(:image_url)
        #     expect(recipe[:attributes][:image_url]).to be_a String
        #   end
        # end

        describe 'edge cases' do
          it "return an empty array if no results found for country or empty string given", :vcr do
            get api_v1_recipes_path(country: 'XXXXXXXXXXXXXXX')

            expect(response).to be_successful
            
            parsed = JSON.parse(response.body, symbolize_names: true)
            
            recipes = parsed[:data]

            expect(recipes).to be_an Array
            expect(recipes.empty?).to be true
          end
        end
      end
    end
  end
end