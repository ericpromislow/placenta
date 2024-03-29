class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @greeting = "Account-activation greeting needs changing"
    @user = user
    mail to: user.email, subject: "#{ ApplicationHelper::APPNAME.capitalize } account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user=nil)
    @greeting = "Password reset time!"
    @user = user || User.first
    mail to: @user.email, subject: "#{ ApplicationHelper::APPNAME.capitalize } password reset"
  end
end
