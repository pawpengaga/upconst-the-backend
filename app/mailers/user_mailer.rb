class UserMailer < ApplicationMailer
  default_url_options[:host] = Rails.application.config.action_mailer.default_url_options[:host]

  def password_reset(user)
    @user = user
    @reset_url = edit_user_password_url(@user, reset_password_token: @user.reset_password_token)
    mail(to: @user.email, subject: 'Recuperar contraseña - UpConst')
  end
end
