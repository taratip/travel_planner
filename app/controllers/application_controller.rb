class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  def authenticate_user
    if !user_signed_in?
      raise ActionController::RoutingError.new("Not Found")
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def layout_by_resource
    if devise_controller? || (devise_controller? && resource_name == :user && action_name == 'new')
      "devise"
    else
      "application"
    end
  end
end
