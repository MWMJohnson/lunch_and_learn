class PexelsService
  def images_by_country(search)
    get_url("search?query=#{search}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.pexels.com/v1/') do |faraday|
      faraday.headers['Authorization'] = ENV['PEXELS_API_KEY']
    end
  end
end