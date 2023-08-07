require 'rails_helper'

RSpec.describe YoutubeVideo do
  it "exists" do
    data = {
      snippet: {
        title: "Quick History of Thailand"
      },
      id: {
        videoId: "Awked9123829"
      }
    }

    video = YoutubeVideo.new(data)

    expect(video.title).to eq(data[:snippet][:title])
    expect(video.youtube_video_id).to eq(data[:id][:videoId])
  end
end