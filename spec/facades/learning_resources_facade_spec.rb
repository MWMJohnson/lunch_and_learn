require 'rails_helper'

RSpec.describe LearningResourcesFacade do
  describe "Learning Resource" do
    describe "get_learning_resources" do
      it "returns a learning resource for a given country", :vcr do
        country = {country: 'france'}

        learning_resource = LearningResourcesFacade.new(country).get_learning_resources

        expect(learning_resource).to be_a LearningResource


        expect(learning_resource.country).to eq('france')
        expect(learning_resource.id).to eq(nil)
        expect(learning_resource.images).to be_an Array
        learning_resource.images.each do |image|
          expect(image).to be_a Hash
          expect(image).to have_key("alt_tag")
          expect(image["alt_tag"]).to be_a String
          expect(image).to have_key("url")
          expect(image["url"]).to be_a String
        end

        expect(learning_resource.video).to be_a Hash
        expect(learning_resource.video).to have_key("title")
        expect(learning_resource.video["title"]).to be_a String
        expect(learning_resource.video).to have_key("youtube_video_id")
        expect(learning_resource.video["youtube_video_id"]).to be_a String
      end
    end
  end
end