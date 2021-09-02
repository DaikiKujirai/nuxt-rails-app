class Api::V1::PostsController < ApplicationController
  include Pagination
  def index
    posts = Post.joins(:user).select("
      posts.id        ,
      posts.post_id   ,
      posts.user_id   ,
      posts.content   ,
      posts.created_at,
      users.name AS user_name
    ").where(post_id: 0).order(created_at: :desc).page(params[:page]).per(5)
    pagination = resources_with_pagination(posts)
    object = { posts: posts, kaminari: pagination }
    render json: object
  end

  def show
    post = {}
    post[:post]  = Post.find(params[:id])
    post[:user]  = User.find(post[:post].user_id)
    post[:likes] = Like.where(post_id: post[:post].id)
    render json: post
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post
    else
      render json: post.errors.messages
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post
    else
      render json: post.errors.messages
    end
  end

  def destroy
    post = Post.find(params[:id])
    posts = Post.where(post_id: post.id)
    if post.destroy
      posts.destroy_all
      render json: { success_message: '削除しました' }
    else
      render json: { errors_message: '削除に失敗しました' }
    end
  end

  def find_comments
    comments = Post.joins(:user).select("
      posts.id        ,
      posts.post_id   ,
      posts.user_id   ,
      posts.content   ,
      posts.created_at,
      users.name AS user_name
    ").where(post_id: params[:id]).order(created_at: :desc).page(params[:page]).per(5)
    pagination = resources_with_pagination(comments)
    object = { comments: comments, kaminari: pagination }
    render json: object
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :post_id, :content)
  end
end
