class Api::V1::LikesController < ApplicationController
  def like_post
    like = Like.new(like_params)
    if like.save
      user_likes = Like.where(user_id: like.user_id)
      render json: user_likes.as_json
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

  end

  def unlike_comment

  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end
end
