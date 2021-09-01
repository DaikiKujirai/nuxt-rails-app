class Api::V1::PostsController < ApplicationController
  include Pagination
  def index
    puts params
    posts = Post.joins(:user).select("
      posts.id,
      posts.post_id,
      posts.content,
      posts.created_at,
      users.name AS user_name
    ").where(post_id: 0).order(created_at: :desc).page(params[:page]).per(5)
    pagination = resources_with_pagination(posts)
    object = { posts: posts, kaminari: pagination }
    render json: object
  end

  def show
    post = Post.includes(:user, :likes).find(params[:id])
    render json: post, include: [:user, :likes]
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: { success_message: '保存しました' }
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
    comments = Post.where(post_id: params[:id])
    render json: comments, include: [:user, :likes]
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :post_id, :content)
  end
end
