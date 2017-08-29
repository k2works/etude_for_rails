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
      msg = DesignPattern::Coc::Message.new('smtp://tom@russolsen.com','smtp://fred@russolsen.com','body')
      msg_gw = DesignPattern::Coc::MessageGatewayStub.new
      expected = <<-EOF
tom@russolsen.com
fred@russolsen.com
body
      EOF
      expect { msg_gw.process_message(msg) }.to output(expected).to_stdout
    end

    it 'authorize host' do
      msg = DesignPattern::Coc::Message.new('smtp://tom@russolsen.com','smtp://fred@russolsen.com','body')
      msg_gw = DesignPattern::Coc::MessageGatewayStub.new

      expect(msg_gw.authorized?(msg)).to be true
    end
  end
end