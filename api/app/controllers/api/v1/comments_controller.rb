class Api::V1::CommentsController < ApplicationController

  def show
    comment = Comment.find(params[:id])
    render json: comment
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors.messages
    end
  end

  def update
    comment = Comment.find(params[:id])
    comment.content = params[:content]
    if comment.update(comment_params)
      render json: comment, include: [:user, :like_comments]
    else
      comment.errors.messages
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comments = Comment.where(comment_id: params[:id])
    if comment.destroy
      comments.destroy_all
      render json: { success_message: '削除しました' }
    else
      render json: { error_message: '削除に失敗しました' }
    end
  end

  def search_comments
    comments = Comment.where(comment_id: params[:id]).includes(:post, :user, :like_comments).order(created_at: :desc)
    render json: comments
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :comment_id, :content)
  end
end
