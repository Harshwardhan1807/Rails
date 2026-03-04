class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :age, :role])
  end
end
