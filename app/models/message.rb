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

  def logging
    f = Fluent::Logger::LevelFluentLogger.new('fluent')

    f.formatter = proc do |severity, datetime, progname, message|
      map = { level: severity }
      map[:message] = message if message
      map[:progname] = progname if progname
      map[:stage] = ENV['RAILS_ENV']
      map[:service_name] = "SomeApp"
      map
    end

    f.info("some_application"){"some application running."}
  end

  def self.exec(message)
    msg = Message.new
    msg.body = message
    msg.logging
    msg.save
    msg.notification
  end
end
