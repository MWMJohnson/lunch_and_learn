class AirQualityFacade
    attr_reader :country

  def initialize(params = {})
    @country = params[:country]
  end

  def capital_aq_index
    if @country
      country_data = country_service.get_country_data(@country)
      capital_city = country_data[0][:capital].first
      capital_air_quality_data = air_quality_service.get_capital_air_quality_data(capital_city)
      AirQuality.new(capital_air_quality_data , capital_city)
    else
      #path for no country entered
    end
  end

  def air_quality_service
    AirQualityService.new
  end

  def country_service
    CountryService.new
  end
end