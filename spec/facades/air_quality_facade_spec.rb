require 'rails_helper'

RSpec.describe AirQualityFacade do

  describe "#initialize" do 
    it "exists and has attributes" do 
      search = {country: "France"}
      facade = AirQualityFacade.new(search)

      expect(facade).to be_a AirQualityFacade
      expect(facade.country).to eq("France")
    end
  end

  describe "#capital_aq_index" do
    it "creates an AirQuality object for a capital city based on the country searched" do
      search = {country: "France"}
      air_quality = AirQualityFacade.new(search).capital_aq_index

      expect(air_quality).to be_an(AirQuality)
  
      expect(air_quality.id).to eq("null")
      expect(air_quality.id).to be_a(String)

      expect(air_quality.type).to eq("air_quality")
      expect(air_quality.type).to be_a(String)

      expect(air_quality.aqi).to eq(55)
      expect(air_quality.aqi).to be_a(Integer)

      expect(air_quality.city).to eq("Paris")
      expect(air_quality.city).to be_a(String)

      expect(air_quality.pm25_concentration).to eq(3.75)
      expect(air_quality.pm25_concentration).to be_a(Float)

      expect(air_quality.co_concentration).to eq(233.65)
      expect(air_quality.co_concentration).to be_a(Float)
    end
  end
end