class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email, :current_password)
  end
end