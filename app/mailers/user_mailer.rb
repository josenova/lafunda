class UserMailer < ActionMailer::Base
  default from: "servicioalcliente@lafunda.do"

  def new_entry(user, inquiry)
    @user = user
    @inquiry = inquiry
    mail(to: @user.email, subject: "[Ticket ##{@inquiry.id}] #{@inquiry.subject}")
  end
  #handle_asynchronously :new_entry

end
