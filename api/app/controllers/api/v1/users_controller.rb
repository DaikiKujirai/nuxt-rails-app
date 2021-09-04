class Api::V1::UsersController < ApplicationController
  include Pagination
  def index
    users = User.all
    render json: users.as_json(only: %i[id name introduction])
  end

  def show
    user = User.find(params[:id])
    render json: user
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

  def show_user_posts
    user_posts = Post.find_user_posts(params[:id]).page(params[:page]).per(5)
    pagination = resources_with_pagination(user_posts)
    object     = { user_posts: user_posts, kaminari: pagination }
    render json: object
  end

  def show_user_like_posts
    user_likes      = Like.find_user_likes(params[:id]).page(params[:page]).per(5)
    user_like_posts = Post.find_user_like_posts(user_likes)
    pagination      = resources_with_pagination(user_likes)
    object          = { user_like_posts: user_like_posts, kaminari: pagination }
    render json: object
  end

  def show_user_comments
    user_comments = Post.find_user_comments(params[:id]).page(params[:page]).per(5)
    pagination    = resources_with_pagination(user_comments)
    object        = { user_comments: user_comments, kaminari: pagination }
    render json: object
  end

  def is_following
    if Relationship.exists?(user_id: params[:id], follow_id: params[:user_id])
      render json: true
    else
      render json: false
    end
  end

  private

  def user_params
    params.require(:user).permit(
                                :name        ,
                                :email       ,
                                :uid         ,
                                :introduction,
                                :is_active   ,
                                :admin
                              )
  end

end
