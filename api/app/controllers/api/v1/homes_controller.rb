class Api::V1::HomesController < ApplicationController
  def index
    render json: "hello"
  end
end
