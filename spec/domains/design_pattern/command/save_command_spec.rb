require 'rails_helper'

describe DesignPattern::Command::SaveCommand do
  describe '#executee' do
    it 'save documents' do
      save_button = DesignPattern::Command::SlickButton.new(DesignPattern::Command::SaveCommand.new)
      expected = <<-EOS
現在の文書を保存
      EOS
      expect { save_button.on_button_push }.to output(expected).to_stdout
    end
  end
end