class Api::V1::LikesController < ApplicationController
  def like_post
    like = Like.new(like_params)
    byebug
    if like.save
      user_likes = Like.where(user_id: like.user_id)
      render json: user_likes.as_json
    else
      puts '失敗'
      render json: { error_message: '失敗しました' }
    end
  end

  def unlike_post
    like = Like.find_by(likeable_type: "post", likeable_id: params[:id])
    if like.destroy
      user_likes = Like.where(user_id: like.user_id)
      render json: user_likes.as_json
    end
  end

  def like_comment
    like = Like.new(like_params)
    byebug
    if like.save
      user_likes = Like.where(user_id: like.user_id)
      render json: user_likes.as_json
    end
  end

  def unlike_comment
    like = Like.find_by(likeable_type: "comment", likeable_id: params[:id])
    if like.destroy
      user_likes = Like.where(user_id: like.user_id)
      render json: user_likes.as_json
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end
end
