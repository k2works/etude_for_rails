# == Schema Information
#
# Table name: messages # ジョブメッセージ
#
#  id         :integer          not null, primary key
#  body       :text(65535)                            # 本文
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ApplicationRecord
  def notification
    NotificationJob.set(wait: 5.seconds).perform_later body
  end

  def self.exec(message)
    msg = Message.new
    msg.body = message
    msg.save
    msg.notification
  end
end
