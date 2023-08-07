class AirQualitySerializer
  include JSONAPI::Serializer
  attributes :aqi, :pm25_concentration, :co_concentration, :city
end