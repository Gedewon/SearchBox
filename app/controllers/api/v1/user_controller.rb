class Api::V1::UserController < ApplicationController
  def index
    @new_user = User.create
    render json: @new_user.id, status: :created
  end
end
