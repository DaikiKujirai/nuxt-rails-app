class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.all.includes(:user).order(created_at: :desc)
    render json: posts, each_serializer: PostSerializer
  end

  def show
    post = Post.includes([:user]).find(params[:id])
    unless Post.nil?
      render json: post, include: [
        :user,
        { comments: [:user] }
      ]
    else
      render json: { error_message: 'Not Found' }
    end
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
      render json: post, include: [:user, { comments: [:user] }]
    else
      render json: post.errors.messages
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      render json: { success_message: '削除しました' }
    else
      render json: post.errors
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :content)
  end
end
