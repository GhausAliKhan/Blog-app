class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :authorize_index, only: [:index]

  def index
    redirect_to user_path(current_user) if current_user && !current_user.admin?
    @users = User.includes(:posts).all
  end

  def show; end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'User not found. Redirecting to users list.'
    redirect_to users_path
  end

  def authorize_index
    authorize! :index, User
  end
end
