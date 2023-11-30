class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Makes the current_user method available to views
  helper_method :current_user

  private

  # Defines the method to find or create the current_user from the first user in the database:
  def current_user
    @current_user ||= User.first
  end
end
