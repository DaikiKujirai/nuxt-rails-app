class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.all.includes(
      :user,
      :like_posts,
      { comments: [:user] },
      { comments: [:like_comments] }
    ).order(created_at: :desc)
    render json: posts, include: [
      :user,
      :like_posts,
      { comments: [:user] },
      { comments: [:like_comment] }
    ]
  end

  def show
    post = Post.includes(
        :user,
        { comments: [:user] },
        { comments: [:like_comments] }
    ).find(params[:id])
    unless Post.nil?
      render json: post, include: [
        :user,
        :like_posts,
        { comments: [:user] },
        { comments: [:like_comment] }
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
      render json: post
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
    params.require(:post).permit(:user_id, :content)
  end
end
