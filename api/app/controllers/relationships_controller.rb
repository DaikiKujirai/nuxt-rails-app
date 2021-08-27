class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
  end

  def destroy

  end
end
