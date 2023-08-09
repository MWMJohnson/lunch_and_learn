require 'rails_helper'

RSpec.describe 'Favorites' do
  describe 'POST api_v1_users_favorites_path' do 
    describe 'happy path' do 
      it "lets a user add a country's recipe to their favorites" do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
                      }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post '/api/v1/users', headers:, params: JSON.generate(user_params)
        user = User.last

        favorite_params = {
                            api_key: user.api_key,
                            country: "thailand",
                            recipe_link: "www.food.com/",
                            recipe_title: "Pandang Curry"
                          }

        post '/api/v1/favorites', headers:, params: JSON.generate(favorite_params)
        
        user_favorite = User.last.favorites.last
        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(201)
        
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to be_a Hash
        expect(result).to have_key(:success)
        expect(result[:success]).to be_a String
        expect(result[:success]).to eq("Favorite added successfully")

        expect(user.favorites.last.recipe_title).to eq("Pandang Curry")
        expect(user.favorites.last.recipe_link).to eq("www.food.com/")
        expect(user.favorites.last.country).to eq("thailand")
        expect(user.favorites.last.user).to eq(user)
      end
    end

    describe 'sad path' do 
      it "rejects adding a favorite recipe if the user is not authenicated" do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
                      }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post '/api/v1/users', headers:, params: JSON.generate(user_params)
        user = User.last

        favorite_params = {
                            api_key: "11111111111",
                            country: "thailand",
                            recipe_link: "www.food.com/",
                            recipe_title: "Pandang Curry"
                          }

        post '/api/v1/favorites', headers:, params: JSON.generate(favorite_params)
        
        user_favorite = User.last.favorites.last
        result = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(401)
        
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to be_a Hash
        expect(result).to have_key(:error)
        expect(result[:error]).to be_a String
        expect(result[:error]).to eq("Unauthorized to add this recipe as a favorite")
      end
    end
  end
end