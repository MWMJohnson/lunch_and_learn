require 'rails_helper'

RSpec.describe 'Login User' do
  describe 'POST api_v1_sessions_path' do 
    describe 'happy path' do 
      it 'logins a user' do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post '/api/v1/users', headers:, params: JSON.generate(user_params)

        user_params = {
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf'
        }

        post '/api/v1/sessions', headers:, params: JSON.generate(user_params)

        created_user = User.last
        result = JSON.parse(response.body, symbolize_names: true)
        
        expect(response).to be_successful

        expect(result).to be_a Hash
        expect(result).to have_key :data
        
        data = result[:data]

        expect(data).to be_a Hash

        expect(data).to have_key :id
        expect(data[:id]).to be_a String
        expect(data[:id]).to eq created_user.id.to_s

        expect(data).to have_key :type
        expect(data[:type]).to be_a String
        expect(data[:type]).to eq('user')

        expect(data).to have_key :attributes

        attributes = data[:attributes]
        expect(attributes).to be_a Hash

        expect(attributes).to have_key(:name)
        expect(attributes[:name]).to be_a String
        expect(attributes[:name]).to eq(created_user.name)

        expect(attributes).to have_key(:email)
        expect(attributes[:email]).to be_a String
        expect(attributes[:email]).to eq(created_user.email)

        expect(attributes).to have_key(:api_key)
        expect(attributes[:api_key]).to be_a String
        expect(attributes[:api_key]).to eq(created_user.api_key)
      end
    end

    describe 'sad path' do 
      it 'does not login a user when an email is missing or incorrect' do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post '/api/v1/users', headers:, params: JSON.generate(user_params)

        user_params = {
          email: ' ',
          password: 'treats4lyf'
        }
        post '/api/v1/sessions', headers:, params: JSON.generate(user_params)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to be_a Hash
        expect(result).to have_key(:error)
        expect(result[:error]).to be_a Array
        expect(result[:error][0]).to be_a String
        expect(result[:error][0]).to eq("Bad Credentials")
      end

      it 'does not login a user when a password is missing or incorrect' do
        user_params = {
          name: 'Odell',
          email: 'goodboy@ruffruff.com',
          password: 'treats4lyf',
          password_confirmation: 'treats4lyf'
        }
        headers = { 'CONTENT_TYPE' => 'application/json' }
        post '/api/v1/users', headers:, params: JSON.generate(user_params)

        user_params = {
          email: 'goodboy@ruffruff.com',
          password: ' '
        }
        post '/api/v1/sessions', headers:, params: JSON.generate(user_params)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to be_a Hash
        expect(result).to have_key(:error)
        expect(result[:error]).to be_a Array
        expect(result[:error][0]).to be_a String
        expect(result[:error][0]).to eq("Bad Credentials")
      end
    end
  end
end