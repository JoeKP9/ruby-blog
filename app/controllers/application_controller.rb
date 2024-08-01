class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :define_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?


  def define_current_user
    @current_user = current_user # call the 'current_user' method defined elsewhere
  end

  include Pagy::Backend

  protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :current_password])
    end

end
