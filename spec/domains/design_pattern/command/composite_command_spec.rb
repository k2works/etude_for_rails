require 'rails_helper'

describe DesignPattern::Command::CompositeCommand do
  describe '#description' do
    it 'describe command' do
      cmds = DesignPattern::Command::CompositeCommand.new
      cmds.add_command(DesignPattern::Command::CreateFile.new('file1.txt', "hellow world\n"))
      cmds.add_command(DesignPattern::Command::CopyFile.new('file1.txt', 'file2.txt'))
      cmds.add_command(DesignPattern::Command::DeleteFile.new('file1.txt'))
      expected = <<-EOS
Create file: file1.txt
Copy file: file1.txt to file2.txt
Delete file: file1.txt
      EOS
      expect { puts (cmds.description) }.to output(expected).to_stdout
    end
  end
end