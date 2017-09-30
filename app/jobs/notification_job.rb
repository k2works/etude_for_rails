class NotificationJob < ApplicationJob
  queue_as :default

  def perform(message)
    Rails.logger.info(message)
    mail_address = ENV['ADMIN_MAIL']
    NotificationMailer.send_notification(mail_address,message).deliver_now
  end
end
