class Api::V1::LearningResourcesController < ApplicationController
  def index
    @facade = LearningResourcesFacade.new(params)
    render json: LearningResourceSerializer.new(@facade.get_learning_resources)
  end
end