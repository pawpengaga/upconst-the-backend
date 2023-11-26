class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  respond_to :json

  def update
    if current_user.update(user_params)
      render json: {
        status: { code: 200, message: 'Usuario actualizado exitosamente.' },
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: { message: "Error al actualizar usuario. #{current_user.errors.full_messages.to_sentence}" },
        status: :unprocessable_entity
      }
    end
  end

  private

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Registro satisfactorio.'},
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
      else
        render json: {
          status: {message: "Usuario no pudo ser creado. #{current_user.errors.full_messages.to_sentence}"},
          status: :unprocessable_entity
        }
    end
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar])
  end
end
