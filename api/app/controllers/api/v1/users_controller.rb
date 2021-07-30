class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users.as_json(only: %i[id name introduction])
  end

  def show
    user = User.find_by(id: params[:id])
    unless User.nil?
      render json: user.as_json(only: %i[id name introduction])
    else
      render json: { error_message: 'Not Found' }
    end
  end
end
