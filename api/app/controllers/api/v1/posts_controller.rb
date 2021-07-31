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
    if post.save
      render json: { success_message: '保存しました' }
    else
      render json: post.errors.messages
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      render json: post.as_json
    else
      render json: post.errors.messages
    end
  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
