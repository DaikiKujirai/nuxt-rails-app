class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.includes(:user, :like_posts).all.order(created_at: :desc)
    render json: posts, include: [
                                :user      ,
                                :like_posts,
                                { comments: [:user]         },
                                { comments: [:like_comment] }
                              ]
  end

  def show
    post = Post.includes(:user).find(params[:id])
    render json: post, include: [
                              :user      ,
                              :like_posts,
                              { comments: [:user]         },
                              { comments: [:like_comment] }
                            ]
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
