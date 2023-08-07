require 'rails_helper'

RSpec.describe AirQuality do
  it 'exists' do
    capital_city = "Paris"
    data = {
      overall_aqi: 66,
      "PM2.5": {concentration: 3.13},
      CO: {concentration: 226.97}
    }

    air_quality = AirQuality.new(data, capital_city)

    expect(air_quality).to be_a AirQuality

    expect(air_quality.id).to eq("null")
    expect(air_quality.id).to be_a(String)

    expect(air_quality.type).to eq("air_quality")
    expect(air_quality.type).to be_a(String)

    expect(air_quality.aqi).to eq(66)
    expect(air_quality.aqi).to be_a(Integer)

    expect(air_quality.city).to eq("Paris")
    expect(air_quality.city).to be_a(String)

    expect(air_quality.pm25_concentration).to eq(3.13)
    expect(air_quality.pm25_concentration).to be_a(Float)

    expect(air_quality.co_concentration).to eq(226.97)
    expect(air_quality.co_concentration).to be_a(Float)
  end
end
