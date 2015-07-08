class UserMailer < ApplicationMailer
  default from: 'notification@example.com'

  def welcome_email(user)
    @user = user
    email_with_name = %("#{user.name}" <#{user.email}>)
    @url  = 'http://localhost:3000'
    mail(to: email_with_name, subject: 'Welcom to My  Awesome Site')
  end
end
