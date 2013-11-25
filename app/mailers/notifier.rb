class Notifier < ActionMailer::Base
  default :from =>  Rcplugin::SMTP_FROM

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_group_email(user,msg,subject)
    @user = user
    @msg = msg
    mail( :to => @user.email,:subject => subject )
  end
end
