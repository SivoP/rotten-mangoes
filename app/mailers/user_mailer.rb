class UserMailer <  ActionMailer::Base
  default from: "siv@rottenmangoes.com"

  def goodbye_email(user)
    @user = user
    mail(to: @user.email, subject: 'sorry to see you go!')
  end
end
