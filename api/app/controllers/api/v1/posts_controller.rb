class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.all
    render json: posts.as_json
  end

  def show
    post = Post.find(params[:id])
    unless Post.nil?
      render json: post.as_json
    else
      render json: { error_message: 'Not Found' }
    end
  end

  def create
    post = Post.new(post_params)
    post.user_id = User.find_by(uid: params[:user_uid]).id
    if post.save
      render json: { success_message: '保存しました' }
    else
      render json: post.errors.messages
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: { success_message: '更新しました' }
    else
      render json: post.errors.messages
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      render json: post
    else
      render json: post.errors
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
