class Country
  attr_reader :name
  
  def initialize(details)
    @name = details[:name][:common]
  end
end