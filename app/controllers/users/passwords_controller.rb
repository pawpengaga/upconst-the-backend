# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  before_action :configure_permitted_parameters
  respond_to :json

  def update
    puts "=========== Entering update method ==========="

    user = User.find_by(reset_password_token: params[:reset_password_token])

    if user && user.reset_password_period_valid? && (user.reset_password_token == params[:reset_password_token])
      puts "=========== Token and period are valid ==========="

      if user.update(password: params[:password], password_confirmation: params[:password_confirmation])
        puts "=========== Password updated successfully ==========="
        user.clear_reset_password_token
        render json: { success: true, message: 'Contraseña actualizada exitosamente', errors: [] }
      else
        puts "=========== Error updating password ==========="
        render json: { success: false, message: 'Error al actualizar la contraseña', errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      puts "=========== Token invalid or expired ==========="
      render json: { success: false, message: 'Token inválido o expirado', errors: ['Token inválido o expirado'] }, status: :unprocessable_entity
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
