class Api::V1::AirQualityController < ApplicationController
  def index
    @facade = AirQualityFacade.new(params)
    render json: AirQualitySerializer.new(@facade.capital_aq_index)
  end
end