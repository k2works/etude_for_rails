require 'rails_helper'

describe DesignPattern::Coc::MessageGateway do
  describe '#process_message' do
    it 'send file message' do
      msg = DesignPattern::Coc::Message.new('','file://home/messages/message84.txt','body')
      msg_gw = DesignPattern::Coc::MessageGatewayStub.new
      expected = <<-EOF
body
      EOF
      expect { msg_gw.process_message(msg) }.to output(expected).to_stdout
    end

    it 'send http message' do
      msg = DesignPattern::Coc::Message.new('','http://russolsen.com/some/place','body')
      msg_gw = DesignPattern::Coc::MessageGatewayStub.new
      expected = <<-EOF
russolsen.com
80
/some/place
body
      EOF
      expect { msg_gw.process_message(msg) }.to output(expected).to_stdout
    end

    it 'send smtp message' do
      msg = DesignPattern::Coc::Message.new('smtp://tom@sussolsen.com','smtp://fred@sussolsen.com','body')
      msg_gw = DesignPattern::Coc::MessageGatewayStub.new
      expected = <<-EOF
tom@sussolsen.com
fred@sussolsen.com
body
      EOF
      expect { msg_gw.process_message(msg) }.to output(expected).to_stdout
    end
  end
end