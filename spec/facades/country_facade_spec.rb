require 'rails_helper'

RSpec.describe CountryFacade do
  describe "countries" do
    it "gets all countries as objects", :vcr do
      countries_list = CountryFacade.new.countries

      expect(countries_list).to be_an Array

      countries_list.each do |country|
        expect(country).to be_a Country
        expect(country.name).to be_a String
      end
    end
  end
end
