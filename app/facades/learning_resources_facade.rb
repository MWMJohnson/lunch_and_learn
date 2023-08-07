class LearningResourcesFacade

  def initialize(params = {})
  @country = params[:country]
  end

  def get_learning_resources
    if @country
      video_data = video_service.search_videos(@country)
      video = YoutubeVideo.new(video_data[:items].first).as_json
      images_details = pexel_service.images_by_country(@country)
      images_array = images_details[:photos].slice(0,10)
      images = images_array.map { |image| Pexel.new(image).as_json }
    else 
      #ERROR SERIALIZER 404 or whatever
    end
    @resource = LearningResource.new(@country, video, images)
  end

  def video_service
    VideoService.new
  end

  def pexel_service
    PexelsService.new
  end


end