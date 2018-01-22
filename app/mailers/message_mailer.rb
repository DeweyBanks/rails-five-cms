class MessageMailer < ApplicationMailer

  def notification_email(message)
    @message = message
    @email = 'communications@eheintl.com'
    mail(to: 'deweybanks@gmail.com', subject: 'Contact Message', message: @message)
  end
end
