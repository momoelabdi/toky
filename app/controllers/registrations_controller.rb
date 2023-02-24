class RegistrationsController < Devise::RegistrationsController
  

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :restrict_registration, only: [:new, :create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end

  def restrict_registration
    redirect_to root_path unless current_user.admin == true
  end
end
