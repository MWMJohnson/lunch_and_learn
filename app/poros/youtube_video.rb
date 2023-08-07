class YoutubeVideo
  attr_reader :title, :youtube_video_id

  def initialize(data)
    @title = data.nil? ? nil : data[:snippet][:title]
    @youtube_video_id = data.nil? ? nil : data[:id][:videoId]
  end
end