class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      user.update!(api_key: SecureRandom.hex)
      render json: UserSerializer.new(user), status: 201
    else
      render json: user.errors, status: 422
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end