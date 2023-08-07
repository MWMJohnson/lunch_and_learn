require 'rails_helper'

RSpec.describe 'AirQuality' do
  describe "Fetch Air Quality" do
    describe "By Search" do
      describe "happy paths" do
        it "can get air quality by search" do
          get api_v1_air_quality_index_path(country: 'france')

          expect(response).to be_successful
          
          parsed = JSON.parse(response.body, symbolize_names: true)
          
          air_quality = parsed[:data]

          expect(air_quality).to be_a Hash

          expect(air_quality).to have_key(:id)
          expect(air_quality[:id]).to eq("null")

          expect(air_quality).to have_key(:type)
          expect(air_quality[:type]).to eq('air_quality')

          expect(air_quality).to have_key(:attributes)
          expect(air_quality[:attributes]).to be_a Hash

          expect(air_quality[:attributes]).to have_key(:aqi)
          expect(air_quality[:attributes][:aqi]).to be_an Integer
          expect(air_quality[:attributes][:aqi]).to eq(55)

          expect(air_quality[:attributes]).to have_key(:pm25_concentration)
          expect(air_quality[:attributes][:pm25_concentration]).to be_a Float
          expect(air_quality[:attributes][:pm25_concentration]).to eq(3.75)

          expect(air_quality[:attributes]).to have_key(:co_concentration)
          expect(air_quality[:attributes][:co_concentration]).to be_a Float
          expect(air_quality[:attributes][:co_concentration]).to eq(233.65)

          expect(air_quality[:attributes]).to have_key(:city)
          expect(air_quality[:attributes][:city]).to be_a String
        end
      end
    end
  end
end