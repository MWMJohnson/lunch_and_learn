class LearningResourcesFacade

  def initialize(params = {})
  @country = params[:country]
  end

  def get_learning_resources
      video_data = video_service.search_videos(@country)
      video = YoutubeVideo.new(video_data[:items].first).as_json
      images_details = pexel_service.images(@country)
      images_array = images_details[:photos].slice(0,10)
      images = images_array.map { |image| Pexel.new(image).as_json }
      video = (video["title"].nil? && video["youtube_video_id"].nil?) ? {} : video
      LearningResource.new(@country, video, images)
  end

  def video_service
    VideoService.new
  end

  def pexel_service
    PexelsService.new
  end


end