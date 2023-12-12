class UserMailer < ApplicationMailer
  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: 'Recuperar contraseña - UpConst')
  end
end
