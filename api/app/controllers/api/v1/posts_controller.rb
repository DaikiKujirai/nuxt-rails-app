class Api::V1::PostsController < ApplicationController
  include Pagination
  def index
    posts      = Post.find_posts.page(params[:page]).per(5)
    pagination = resources_with_pagination(posts)
    object     = { posts: posts, kaminari: pagination }
    render json: object
  end

  def show
    post        = {}
    post[:post] = Post.find(params[:id])
    post[:user] = User.find(post[:post].user_id)
    if post[:post].post_id != 0
      post[:reply_to_user] = User.find(post[:post].user_id)
    end
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
    post  = Post.find(params[:id])
    posts = Post.where(post_id: post.id)
    if post.destroy
      posts.destroy_all
      render json: { success_message: '削除しました' }
    else
      render json: { errors_message: '削除に失敗しました' }
    end
  end

  def find_comments
    comments   = Post.find_post_comments(params[:id]).page(params[:page]).per(5)
    pagination = resources_with_pagination(comments)
    object     = { comments: comments, kaminari: pagination }
    render json: object
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :post_id, :content, :image)
  end
end
