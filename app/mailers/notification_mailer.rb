class NotificationMailer < ApplicationMailer
  def send_notification(mail_address,message)
    @message = message
    mail to: mail_address, subject: "Application Notification"
  end
end
