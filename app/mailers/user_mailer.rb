class UserMailer < Devise::Mailer
  default from: "servicioalcliente@lafunda.do"

  def entry_mail(user, inquiry)
    @user = user
    @inquiry = inquiry
    mail(to: @user.email,
         subject: "[Ticket ##{@inquiry.id}] #{@inquiry.subject}"
    )
  end

end
