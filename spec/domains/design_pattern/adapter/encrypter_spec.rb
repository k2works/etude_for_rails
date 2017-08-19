require 'rails_helper'
require 'pathname'

describe DesignPattern::Adapter::Encrypter do
  describe '#encrypt' do
    it 'encrypt file' do
      DesignPattern::Command::CreateFile.new('message.txt', "hellow world\n").execute
      file_in = Pathname.new('message.txt')
      file_out = Pathname.new('message.encrypted')
      reader = File.open(file_in)
      writer = File.open(file_out,'w')
      encrypter = DesignPattern::Adapter::Encrypter.new('my secret key')
      encrypter.encrypt(reader, writer)

      expect(file_out).to exist
      expect(File.open(file_out).read).not_to eq("hellow world\n")

      File.delete(file_out)
      File.delete(file_in)
    end

    it 'encrypt string' do
      encrypter = DesignPattern::Adapter::Encrypter.new('XYZZY')
      reader = DesignPattern::Adapter::StringIOAdapter.new('We attack at dawn')
      file_out = Pathname.new('out.txt')
      writer = File.open(file_out,'w')
      encrypter.encrypt(reader, writer)

      expect(file_out).to exist
      expect(File.open(file_out).read).not_to eq('We attack at dawn')

      File.delete(file_out)
    end
  end
end