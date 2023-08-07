require 'rails_helper'

RSpec.describe PexelsService do
  describe "#images_by_country" do
    it "can get images based on a country search", :vcr do
      country = "thailand"
      response = PexelsService.new.images_by_country(country)

      expect(response).to have_key(:photos)
      expect(response[:photos]).to be_an Array
      
      photos = response[:photos]

      photos.each do |photo|
        expect(photo).to be_a Hash
        expect(photo).to have_key(:url)
        expect(photo[:url]).to be_a String

        expect(photo).to have_key(:photographer)
        expect(photo[:photographer]).to be_a String

        expect(photo).to have_key(:avg_color)
        expect(photo[:avg_color]).to be_a String

        expect(photo).to have_key(:alt)
        expect(photo[:alt]).to be_a String
      end
    end
  end
end