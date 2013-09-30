# Send random password to user with a link to change it if they like
class UserMailer < ActionMailer::Base
  default from: "no-reply@spoutlets.com"

  def welcome_email(user, generated_password)
    @user = user
    @password = generated_password
    @login = signin_url
    mail(to: @user.email, subject: 'Welcome to spoutlets!')
  end

  def password_reset_email(user, random_password)
    @user = user
    @password = random_password
    @login = signin_url
    mail(to: @user.email, subject: 'Password reset for spoutlets!')
  end
end
