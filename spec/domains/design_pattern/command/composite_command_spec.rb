require 'rails_helper'
require 'pathname'

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

  describe '#execute' do
    it 'crate file' do
      cmds = DesignPattern::Command::CompositeCommand.new
      cmds.add_command(DesignPattern::Command::CreateFile.new('file1.txt', "hellow world\n"))
      cmds.add_command(DesignPattern::Command::CopyFile.new('file1.txt', 'file2.txt'))
      cmds.add_command(DesignPattern::Command::DeleteFile.new('file1.txt'))
      cmds.execute
      file = Pathname.new('file2.txt')
      expect(file).to exist
      File.delete(file)
    end
  end

  describe '#unexecute' do
    it 'undo create file' do
      cmds = DesignPattern::Command::CompositeCommand.new
      cmds.add_command(DesignPattern::Command::CreateFile.new('file1.txt', "hellow world\n"))
      cmds.execute
      cmds.unexecute
      file = Pathname.new('file1.txt')
      expect(file).not_to exist
    end

    it 'undo delete file' do
      DesignPattern::Command::CreateFile.new('file1.txt', "hellow world\n").execute
      cmds = DesignPattern::Command::CompositeCommand.new
      cmds.add_command(DesignPattern::Command::DeleteFile.new('file1.txt'))
      cmds.execute
      cmds.unexecute
      file = Pathname.new('file1.txt')
      expect(file).to exist
      File.delete(file)
    end
  end
end