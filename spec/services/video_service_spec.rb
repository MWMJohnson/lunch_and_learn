require 'rails_helper'

RSpec.describe VideoService do
  describe "#search_videos" do
    it "can get educational video info by country", :vcr do
      search = "singapore"
      response = VideoService.new.search_videos(search)

      expect(response).to have_key(:items)
      expect(response[:items]).to be_an Array

      video = response[:items].first

      expect(video).to have_key(:id)
      expect(video[:id]).to be_a Hash

      expect(video[:id]).to have_key(:videoId)
      expect(video[:id][:videoId]).to be_a String

      expect(video[:snippet]).to have_key(:title)
      expect(video[:snippet][:title]).to be_a String

      expect(video).to have_key(:etag)
      expect(video).to have_key(:kind)
    end
  end
end