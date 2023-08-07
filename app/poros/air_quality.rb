class AirQuality
  attr_reader :id,
              :type,
              :aqi,
              :city,
              :pm25_concentration,
              :co_concentration
  
  def initialize(data, capital_city)
    # require 'pry'; binding.pry
    @id = "null"
    @type = "air_quality"
    @aqi = data[:overall_aqi]
    @city = capital_city
    @pm25_concentration = data[:"PM2.5"][:concentration]
    @co_concentration = data[:CO][:concentration]
  end
end