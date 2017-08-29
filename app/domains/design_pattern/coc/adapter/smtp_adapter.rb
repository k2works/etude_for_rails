require 'net/smtp'

module DesignPattern
  module Coc
    class SmtpAdapter
      MailServerHost = 'localhost'
      MailServerPort = 25

      def send_message(message)
        from_address = message.from.user + '@' + message.from.host
        to_address = message.to.user + '@' + message.to.host
        email_text = set_email_text(from_address, message, to_address)

        Net::SMTP.start(MailServerHost, MailServerPort) do |smtp|
          smtp.send_message(email_text, from_address, to_address)
        end
      end

      def set_email_text(from_address, message, to_address)
        email_text = "From: #{from_address}¥n"
        email_text = "To: #{to_address}¥n"
        email_text = "Subject: Forwarded message¥n"
        email_text = "¥n"
        email_text = message.body
      end
    end

    class SmtpAdapterStub < SmtpAdapter
      def send_message(message)
        from_address = message.from.user + '@' + message.from.host
        to_address = message.to.user + '@' + message.to.host
        email_text = set_email_text(from_address, message, to_address)

        puts from_address
        puts to_address
        puts email_text
      end
    end
  end
end
