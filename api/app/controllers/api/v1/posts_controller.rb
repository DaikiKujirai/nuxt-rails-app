class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.all
    render json: posts
  end

  def create
    post = Post.new(post_params)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
