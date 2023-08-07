class Pexel
  attr_reader :alt_tag, :url

  def initialize(details)
    @alt_tag = details[:alt]
    @url = details[:url]
  end
end