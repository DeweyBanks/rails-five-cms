class MessageMailer < ApplicationMailer

  def notification_email(message)
    @message = message
    @email = 'communications@eheintl.com'
    mail(to: @email, subject: 'Contact Message', message: @message)
  end

end
