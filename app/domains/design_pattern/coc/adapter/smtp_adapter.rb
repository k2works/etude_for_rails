require 'net/smtp'

module DesignPattern
  module CoC
    class SmtpAdapter
      MailServerHost = 'localhost'
      MailServerPort = 25

      def send_message(message)
        from_address = message.from.user + '@' + message.from.host
        to_address = message.to.user + '@' + message.to.host

        email_text = "From: #{from_address}¥n"
        email_text = "To: #{to_address}¥n"
        email_text = "Subject: Forwarded message¥n"
        email_text = "¥n"
        email_text = message.body

        Net::SMTP.start(MailServerHost, MailServerPort) do |smtp|
          smtp.send_message(email_text, from_address, to_address)
        end
      end
    end
  end
end
