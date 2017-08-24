require 'rails_helper'

describe DesignPattern::Decorator::WriterDecorator do
  describe '#write_line' do
    it 'write simple line with number' do
      file_out = Pathname.new('tmp/out.txt')
      writer = DesignPattern::Decorator::NumberingWriter.new(DesignPattern::Decorator::SimpleWriter.new(file_out))
      writer.write_line('Hello out there')
      writer.close

      expect(file_out).to exist
      expect(File.open(file_out).read).to eq('1: Hello out there¥n')

      File.delete(file_out)
    end

    it 'write line text with number and checksumming' do
      file_out = Pathname.new('tmp/out.txt')
      writer = DesignPattern::Decorator::CheckSummingWriter.new(
          DesignPattern::Decorator::NumberingWriter.new(
              DesignPattern::Decorator::SimpleWriter.new(file_out)
          )
      )
      writer.write_line('Hello out there')
      writer.close

      expect(file_out).to exist
      expect(File.open(file_out).read).to eq('1: Hello out there¥n')
      expect(writer.check_sum).to be > 0

      File.delete(file_out)
    end

    it 'write line text with number and checksumming and timestamp' do
      file_out = Pathname.new('tmp/out.txt')
      writer = DesignPattern::Decorator::TimeStampingWriter.new(
          DesignPattern::Decorator::CheckSummingWriter.new(
              DesignPattern::Decorator::NumberingWriter.new(
                  DesignPattern::Decorator::SimpleWriter.new(file_out)
              )
          )
      )
      writer.write_line('Hello out there')
      writer.close

      expect(file_out).to exist
      expect(File.open(file_out).read).to include('Hello out there¥n')

      File.delete(file_out)
    end
  end
end