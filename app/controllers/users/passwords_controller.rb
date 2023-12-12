# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  respond_to :json

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
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
