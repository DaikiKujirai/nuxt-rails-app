class Api::V1::PostsController < ApplicationController
  include Pagination
  def home
    current_user = User.find(params[:user_id])
    posts        = Post.find_home_posts(current_user).includes(:user, :likes, :comments).page(params[:page]).per(10)
    pagination   = resources_with_pagination(posts)
    object       = {
                    posts:    posts.as_json(include: [:user, :likes, :comments]),
                    kaminari: pagination
                   }
    render json: object
  end

  def index
    posts      = Post.find_posts.includes(:user, :likes, :comments).page(params[:page]).per(10)
    pagination = resources_with_pagination(posts)
    object     = {
                  posts:    posts.as_json(include: [:user, :likes, :comments]),
                  kaminari: pagination
                 }
    render json: object
  end

  def show
    post = Post.find(params[:id])
    render json: post.as_json(include: [:user, :likes, :comments])
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post
    else
      render json: post.errors.messages
    end
  end

  def create_comment
    comment      = Post.new(post_params)
    post         = Post.find(params[:post][:post_id])
    current_user = User.find(params[:post][:user_id])

    if comment.save
      post.create_notification_comment!(current_user, post.user_id, post, params[:post][:uid]) if post.user_id != current_user.id
      render json: comment
    else
      render json: post.errors.messages
    end
  end

  def update
    post = Post.includes(:user, :likes, :comments).find(params[:id])
    if post.update(post_params)
      render json: post.as_json(include: [:user, :likes, :comments])
    else
      render json: post.errors.messages
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      render json: { success_message: '削除しました' }
    else
      render json: { errors_message: '削除に失敗しました' }
    end
  end

  def find_comments
    comments   = Post.find_post_comments(params[:id]).includes(:user, :likes, :comments).page(params[:page]).per(10)
    pagination = resources_with_pagination(comments)
    object     = { comments: comments.as_json(include: [:user, :likes, :comments]), kaminari: pagination }
    render json: object
  end

  def search
    if params[:page_name] === 'homes-id'
      current_user = User.find(params[:user_id])
      q            = Post.find_home_posts(current_user).ransack(content_cont: params[:q])
    else
      q            = Post.find_posts.ransack(content_cont: params[:q])
    end
    posts          = q.result(distinct: true).includes(:user, :likes, :comments).page(params[:page]).per(10)
    pagination     = resources_with_pagination(posts)
    object         = { posts: posts.as_json(include: [:user, :likes, :comments]), kaminari: pagination }
    render json: object
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :post_id, :content, :image)
  end
end
