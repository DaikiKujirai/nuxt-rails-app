class Api::V1::RelationshipsController < ApplicationController
  def create
    if Relationship.create(user_id: params[:id], follow_id: params[:user_id])
      render json: params[:user_id]
    else
      render json: { errors_message: '失敗しました' }
    end
  end

  def destroy

  end

  private

  def relationship_params
    params.require(:relationships).permit(:user_id, :follow_id)
  end

end
