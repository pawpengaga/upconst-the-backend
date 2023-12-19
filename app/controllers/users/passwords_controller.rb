# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  before_action :configure_permitted_parameters
  respond_to :json

  def update
    user = User.find_by(reset_password_token: params[:reset_password_token])

    if user && user.reset_password_period_valid?
      if user.update(password: params[:password], password_confirmation: params[:password_confirmation])
        render json: { message: 'Contraseña actualizada exitosamente' }
      else
        render json: { error: "no se pudo mano" }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Token inválido o expirado' }, status: :unprocessable_entity
    end
  end

  def forgot
    if params[:email].blank? # check if email is present
      return render json: {error: 'No tiene mail xD'}
    end

    user = User.find_by(email: params[:email]) # if present find user by email

    if user.present?
      user.generate_password_token!
      UserMailer.password_reset(user).deliver_now
      render json: { status: 'Ok enviado tilín' }, status: :ok
    else
      render json: {error: 'Email, no valido, lo has perdido todo XDDDDD'}, status: :not_found
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[password password_confirmation reset_password_token])
  end
end
