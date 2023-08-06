class CountryService

  def pick_random_country
    countries = get_url("v3.1/all")
    country = countries.sample
  end


  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://restcountries.com/')
  end

end