class UserMailer < ApplicationMailer
  default from: 'welcome@odinbook.com'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Odin-book!')
  end
end
