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

  def create
    @user = User.new(user_params)
    @user.is_active = true
    if @user.save
      render json: @user, status: :created
      puts 'create'
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :uid,
      :introduction,
      :is_active,
      :admin
    )
  end

end
