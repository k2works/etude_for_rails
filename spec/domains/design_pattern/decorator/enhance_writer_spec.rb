require 'rails_helper'
require 'pathname'

describe DesignPattern::Decorator::EnhanceWriter do
  describe '#write_line' do
    it 'write line text' do
      file_out = Pathname.new('tmp/out.txt')
      writer = DesignPattern::Decorator::EnhanceWriter.new(file_out)
      writer.write_line("飾り気のない一行")
      writer.close

      expect(file_out).to exist
      expect(File.open(file_out).read).to eq("飾り気のない一行¥n")

      File.delete(file_out)
    end
  end

  describe '#checksumming_write_line' do
    it 'write line text with checksumming' do
      file_out = Pathname.new('tmp/out.txt')
      writer = DesignPattern::Decorator::EnhanceWriter.new(file_out)
      writer.checksumming_write_line('チェックサム付き')
      writer.close

      expect(file_out).to exist
      expect(File.open(file_out).read).to eq("チェックサム付き¥n")
      expect(writer.check_sum).to be > 0

      File.delete(file_out)
    end
  end

  describe '#timestamping_write_line' do
    it 'write line text with timestamp' do
      file_out = Pathname.new('tmp/out.txt')
      writer = DesignPattern::Decorator::EnhanceWriter.new(file_out)
      writer.timestamping_write_line('タイムスタンプ付き')
      writer.close

      expect(file_out).to exist
      expect(File.open(file_out).read).to include("タイムスタンプ付き¥n")

      File.delete(file_out)
    end
  end

  describe '#numbering_write_line' do
    it 'write line text with line number' do
      file_out = Pathname.new('tmp/out.txt')
      writer = DesignPattern::Decorator::EnhanceWriter.new(file_out)
      writer.numbering_write_line('行番号付き')
      writer.close

      expect(file_out).to exist
      expect(File.open(file_out).read).to eq("1: 行番号付き¥n")
      expect(writer.instance_variable_get(:@line_number)).to be > 1

      File.delete(file_out)
    end
  end
end