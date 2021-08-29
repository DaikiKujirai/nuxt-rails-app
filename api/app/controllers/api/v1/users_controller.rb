class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users.as_json(only: %i[id name introduction])
  end

  def show
    user = User.find(params[:id])
    unless User.nil?
      render json: user
    else
      render json: { error_message: 'Not Found' }
    end
  end

  def create
    user = User.new(user_params)
    user.is_active = true
    if user.save
      render json: user, status: :created
    else
      render json: { errors_message: 'メールアドレスまたはパスワードが正しくありません' }
    end
  end

  def find_login_user
    user = User.find_by(uid: params[:uid])
    render json: user
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
