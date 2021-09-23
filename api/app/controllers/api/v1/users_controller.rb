class Api::V1::UsersController < ApplicationController
  include Pagination

  def show
    user = User.includes(:followings, :followers).find(params[:id])
    render json: user.as_json(include: [:followings, :followers])
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

  def update
    user = User.find(params[:user][:id])
    if user.update(user_params)
      render json: user
    else
      render json: { errors_message: '失敗しました' }
    end
  end

  def update_account
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: { errors_message: '失敗しました' }
    end
  end

  def find_login_user
    user = User.find_by(uid: params[:uid])
    render json: user
  end

  def show_user_posts
    user_posts = Post.find_user_posts(params[:id]).includes(:likes, :comments).page(params[:page]).per(10)
    pagination = resources_with_pagination(user_posts)
    object     = { user_posts: user_posts.as_json(include: [:likes, :comments]), kaminari: pagination }
    render json: object
  end

  def show_user_comments
    user_comments = Post.find_user_comments(params[:id]).includes(:likes, :comments).page(params[:page]).per(10)
    pagination    = resources_with_pagination(user_comments)
    object        = { user_comments: user_comments.as_json(include: [:likes, :comments]), kaminari: pagination }
    render json: object
  end

  def show_user_posts_have_image
    user_posts = Post.find_user_posts_have_image(params[:id]).includes(:user, :likes, :comments).page(params[:page]).per(10)
    pagination = resources_with_pagination(user_posts)
    object     = { user_posts: user_posts.as_json(include: [:user, :likes, :comments]), kaminari: pagination }
    render json: object
  end

  def show_user_like_posts
    user       = User.find(params[:id])
    user_likes = user.likes.includes(post: [:user, :likes, :comments]).page(params[:page]).per(10)
    pagination = resources_with_pagination(user_likes)
    object     = { user_likes: user_likes.as_json(include: { post: { include: [:user, :likes, :comments] } }), kaminari: pagination }
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
                                  :avatar      ,
                                  :cover_image ,
                                  :introduction,
                                  :is_active   ,
                                  :admin
                                )
  end

end
