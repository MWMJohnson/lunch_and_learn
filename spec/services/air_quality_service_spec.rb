require 'rails_helper'

RSpec.describe AirQualityService do
  describe "#get_capital_air_quality_data" do
    it "can get all a capital city's air quality info" do
      capital = "Paris"
      service = AirQualityService.new.get_capital_air_quality_data(capital)

      expect(service).to be_an Hash
      
      expect(service).to have_key(:CO)
      expect(service[:CO]).to have_key(:concentration)
      expect(service[:CO][:concentration]).to be_a(Float)
      expect(service[:CO][:concentration]).to eq(233.65)

      expect(service).to have_key(:"PM2.5")
      expect(service[:"PM2.5"]).to have_key(:concentration)
      expect(service[:"PM2.5"][:concentration]).to be_a(Float)
      expect(service[:"PM2.5"][:concentration]).to eq(3.75)
      
      expect(service).to have_key(:overall_aqi)
      expect(service[:overall_aqi]).to be_an Integer
    end
  end
end