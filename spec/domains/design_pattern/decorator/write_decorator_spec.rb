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

    it 'write line using alias' do
      file_out = Pathname.new('tmp/out.txt')
      w = DesignPattern::Decorator::SimpleWriter.new(file_out)

      class << w
         alias old_write_line write_line

         def write_line(line)
           old_write_line("#{Time.new}: #{line}")
         end
      end

      w.write_line('Hello out there')
      w.close

      expect(file_out).to exist
      expect(File.open(file_out).read).to include('Hello out there¥n')

      File.delete(file_out)
    end

    it 'write line using module' do
      module TimeStampingWriter
        def write_line(line)
          super("#{Time.new}: #{line}")
        end
      end

      module CheckSummingWriter
        attr_reader :check_sum

        def write_line(line)
          @check_sum = 0 unless @check_sum
          line.each_byte { |byte| @check_sum = (@check_sum + byte) % 256 }
          super(line)
          @check_sum += "\n".ord % 256
        end
      end

      module NumberingWriter
        attr_reader :line_number

        def write_line(line)
          @line_number = 1 unless @line_number
          super("#{@line_number}: #{line}")
          @line_number += 1
        end
      end

      file_out = Pathname.new('tmp/out.txt')
      w = DesignPattern::Decorator::SimpleWriter.new(file_out)
      w.extend(CheckSummingWriter)
      w.extend(NumberingWriter)

      w.write_line('Hello out there')
      w.close

      expect(file_out).to exist
      expect(File.open(file_out).read).to eq('1: Hello out there¥n')
      expect(w.check_sum).to be > 0

      File.delete(file_out)
    end
  end
end