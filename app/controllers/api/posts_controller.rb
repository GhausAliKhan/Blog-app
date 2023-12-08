class Api::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:index]
  before_action :set_user, only: [:index]

  def index
    @posts = @user.posts
    render json: @posts
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
