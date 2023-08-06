class Recipe
  attr_reader :title,
              :url,
              :country,
              :image,
              :type,
              :id
              

  def initialize(data, country)
    @title = data[:recipe][:label]
    @url = data[:recipe][:uri]
    @country = country
    @image = data[:recipe][:image]
    @id = "null"
    @type = "recipe"
  end
  
end