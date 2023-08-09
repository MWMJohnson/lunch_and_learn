require 'rails_helper'

RSpec.describe Favorite do
  describe "GET api_v1_favorites_path" do
    describe "happy paths" do
      it "can get a user's favorited recipes" do
        user_params = {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf",
          "password_confirmation": "treats4lyf"
        }
  
        headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        post api_v1_users_path, headers: headers, params: JSON.generate(user_params)
  
        user = User.last
        blt = user.favorites.create!(country: "America", recipe_link: "blt_url", recipe_title: "BLT")
        meatballs = user.favorites.create!(country: "Italy", recipe_link: "meatballs_url", recipe_title: "Meatballs")
        
        get api_v1_favorites_path(api_key: user.api_key)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        results = JSON.parse(response.body, symbolize_names: true)

        expect(results).to have_key(:data)
        expect(results[:data]).to be_an Array

        favorite_data = results[:data]

        expect(favorite_data).to be_an Array

        expect(favorite_data[0]).to have_key(:id)
        expect(favorite_data[0][:id]).to be_a String
        expect(favorite_data[0][:id]).to eq blt.id.to_s

        expect(favorite_data[0]).to have_key(:type)
        expect(favorite_data[0][:type]).to be_a String
        expect(favorite_data[0][:type]).to eq("favorite")

        expect(favorite_data[0]).to have_key(:attributes)
        
        attributes = favorite_data[0][:attributes]
        expect(attributes).to be_a Hash

        expect(attributes).to have_key(:recipe_link)
        expect(attributes[:recipe_link]).to be_a String
        expect(attributes[:recipe_link]).to eq(blt.recipe_link)

        expect(attributes).to have_key(:recipe_title)
        expect(attributes[:recipe_title]).to be_a String
        expect(attributes[:recipe_title]).to eq(blt.recipe_title)

        expect(attributes).to have_key(:country)
        expect(attributes[:country]).to be_a String
        expect(attributes[:country]).to eq(blt.country)

        expect(attributes).to have_key(:created_at)
        expect(attributes[:created_at]).to be_a String
        expect(attributes[:created_at]).to eq(blt.created_at.as_json)
      end

      it "returns an empty array if there are no favorites" do
        user_params = {
          "name": "Odell",
          "email": "badboy@ruffruff.com",
          "password": "test",
          "password_confirmation": "test"
        }
  
        headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
        post api_v1_users_path, headers: headers, params: JSON.generate(user_params)
  
        user = User.last
  
        get api_v1_favorites_path(api_key: user.api_key)
  
        expect(response).to be_successful
        expect(response.status).to eq(200)
  
        results = JSON.parse(response.body, symbolize_names: true)

        expect(results).to have_key(:data)
        expect(results[:data]).to be_an Array
        expect(results[:data]).to eq([])
        expect(results[:data][0]).to eq(nil)
      end
    end

    describe "sad paths" do
      it "rejects request if user does not exists" do
        get api_v1_favorites_path(api_key: "111111111")
  
        expect(response).to_not be_successful
        expect(response.status).to eq(401)
  
        results = JSON.parse(response.body, symbolize_names: true)

        expect(results).to be_a Hash
        expect(results).to have_key :error
        expect(results[:error]).to be_a String
        expect(results[:error]).to eq("Unauthorized")
      end
    end
  end
end