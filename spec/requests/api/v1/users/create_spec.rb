require 'rails_helper'

RSpec.describe 'Register User' do
  describe 'POST api_v1_users_path' do 
    describe 'happy path' do 
      it 'registers a user', :vcr do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post '/api/v1/users', headers:, params: JSON.generate(user_params)
        user = User.last
        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        
        expect(user.name).to eq(user_params[:name])
        expect(user.email).to eq(user_params[:email])
        expect(user.password).to eq(nil)
        expect(user.password_confirmation).to eq(nil)
        expect(user.api_key.length).to eq(32)

        expect(result).to have_key(:data)
        expect(result[:data]).to be_a Hash

        data = result[:data]

        expect(data).to have_key(:id)
        expect(data[:id]).to be_a String
        expect(data[:id]).to eq(user.id.to_s)

        expect(data).to have_key(:type)
        expect(data[:type]).to be_a String
        expect(data[:type]).to eq('user')

        expect(data).to have_key(:attributes)
        expect(data[:attributes]).to be_a Hash
        
        attributes = data[:attributes]

        expect(attributes).to have_key(:name)
        expect(attributes[:name]).to be_a String
        expect(attributes[:name]).to eq(user.name)

        expect(attributes).to have_key(:email)
        expect(attributes[:email]).to be_a String
        expect(attributes[:email]).to eq(user.email)

        expect(attributes).to have_key(:api_key)
        expect(attributes[:api_key]).to be_a String
        expect(attributes[:api_key]).to eq(user.api_key)
      end
    end

  describe "sad path"
    it 'renders error if email is not unique' do
      user_params = {
        name: 'Odell',
        email: 'goodboy@ruffruff.com',
        password: 'treats4lyf',
        password_confirmation: 'treats4lyf'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers:, params: JSON.generate(user_params)
      post '/api/v1/users', headers:, params: JSON.generate(user_params)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result).to have_key(:email)
      expect(result[:email]).to be_a Array
      expect(result[:email][0]).to be_a String
      expect(result[:email][0]).to eq("has already been taken")
    end

    it 'renders error if password does not match' do
      user_params = {
        name: 'Odell',
        email: 'goodboy@ruffruff.com',
        password: 'treats4lyf',
        password_confirmation: ''
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post '/api/v1/users', headers:, params: JSON.generate(user_params)

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a Hash
      expect(result).to have_key(:password_confirmation)
      expect(result[:password_confirmation]).to be_a Array
      expect(result[:password_confirmation][0]).to be_a String
      expect(result[:password_confirmation][0]).to eq("doesn't match Password")
    end
  end
end
