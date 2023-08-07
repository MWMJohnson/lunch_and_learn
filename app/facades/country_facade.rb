class CountryFacade
  def countries
    data = service.get_all_countries
    data.map { |result| Country.new(result) }
  end

  def service
    CountryService.new
  end
end