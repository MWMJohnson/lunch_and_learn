class CountryService

  def pick_random_country
    countries = get_url("v3.1/all")
    country = countries.sample
  end

  def get_all_countries
    get_url("v3.1/all")
  end


  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://restcountries.com/')
  end

  def get_country_data(country)
    get_url("v3.1/name/#{country}")
  end

end