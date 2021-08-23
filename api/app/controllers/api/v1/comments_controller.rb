class Api::V1::CommentsController < ApplicationController

  def show
    comment = Comment.find(params[:id])
    render json: comment
  end

  def create
    comment = Comment.new(comment_params)
    comment.user_id = User.find_by(uid: params[:user_uid]).id
    if comment.save
      render json: comment
    else
      render json: comment.errors.messages
    end
  end

  def update
    comment = Comment.find(params[:id])
    comment.content = params[:content]
    if comment.update(comment_params) && comment.comment_id == 0
      post = Post.find(params[:post_id])
      render json: post, include: [:user, { comments: [:user] }]
    elsif comment.update(comment_params) && comment.comment_id != 0
    else
      comment.errors.messages
    end
  end

  def search_comments
    comments = Comment.where(comment_id: params[:id]).includes(:post, :user).order(id: :desc)
    render json: comments
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :comment_id, :content)
  end
end
