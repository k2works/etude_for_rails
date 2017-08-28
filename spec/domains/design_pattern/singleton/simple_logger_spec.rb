require 'rails_helper'
require 'pathname'

describe DesignPattern::Singleton::SimpleLogger do
  describe '#info' do
    it 'logging info' do
      log_file = Pathname.new('log.txt')
      logger = DesignPattern::Singleton::SimpleLogger.new
      logger.level = DesignPattern::Singleton::SimpleLogger::INFO

      logger.info('1番目の処理を実行')
      logger.info('2番目の処理を実行')

      expect(log_file).to exist
      expect(File.open(log_file).read).to eq("1番目の処理を実行\n2番目の処理を実行\n")

      File.delete(log_file)
    end
  end
end