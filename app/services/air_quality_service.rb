class AirQualityService

  def get_capital_air_quality_data(capital)
    get_url("?city=#{capital}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.api-ninjas.com/v1/airquality') do |faraday|
      faraday.headers['Accept'] = 'application/json'
      faraday.headers['X-Api-Key'] = ENV['NINJA_API_KEY']
    end
  end

end