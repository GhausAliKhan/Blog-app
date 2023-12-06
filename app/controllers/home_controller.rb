class HomeController < ApplicationController
  def index
    @resource = User.new
    @resource_name = :user
    @resource_class = User
    @devise_mapping = Devise.mappings[:user]
  end
end
