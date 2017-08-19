require 'rails_helper'

describe DesignPattern::Adapter::Renderer do
  describe '#render' do
    it 'render text object' do
      to = DesignPattern::Adapter::TextObject.new('Text',1,'Blue')
      renderer = DesignPattern::Adapter::Renderer.new

      expected = <<-EOF
Text is Text
1 inch
Color is Blue
      EOF

      expect { renderer.render(to) }.to output(expected).to_stdout
    end

    it 'render british text object' do
      bto = DesignPattern::Adapter::BritishTextObject.new('String',50.8,'Red')
      adapter = DesignPattern::Adapter::BritishTextObjectAdapter.new(bto)
      renderer = DesignPattern::Adapter::Renderer.new

      expected = <<-EOF
Text is String
2.0 inch
Color is Red
      EOF

      expect { renderer.render(adapter) }.to output(expected).to_stdout
    end

    it 'render british text object using singleton class' do
      bto = DesignPattern::Adapter::BritishTextObject.new('String',50.8,'Red')
      renderer = DesignPattern::Adapter::Renderer.new

      expected = <<-EOF
Text is String
2.0 inch
Color is Red
      EOF

      expect { renderer.render(bto) }.to output(expected).to_stdout
    end
  end
end