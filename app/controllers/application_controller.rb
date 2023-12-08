class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # This method allows us to accept additional parameters for the user
  # sign-up and account update processes.
  def configure_permitted_parameters
    # For sign-up, permit :name, :bio, :photo, and other required parameters.
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email bio photo password password_confirmation])

    # For account updates, permit :name, :bio, :photo, and any other parameters
    # that might be needed for updating the user's account.
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name bio photo])
  end

  # This method determines where to redirect after a successful sign-in.
  def after_sign_in_path_for(_resource)
    # Redirect to the user index page or any other path you want to send the user to after sign-in.
    users_path # or user_path(current_user) to redirect to the user's show page.
  end
end
