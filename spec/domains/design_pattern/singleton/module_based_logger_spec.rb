require 'rails_helper'
require 'pathname'

describe DesignPattern::Singleton::ModuleBasedLogger do
  let(:log_file) { log_file = Pathname.new('log2.txt') }

  describe '#info' do
    it 'logging info' do
      logger = DesignPattern::Singleton::ModuleBasedLogger
      logger.level = DesignPattern::Singleton::ModuleBasedLogger::INFO

      logger.info('コンピュータがチェスゲームに勝ちました。')

      expect(log_file).to exist
      expect(File.open(log_file).read).to eq("コンピュータがチェスゲームに勝ちました。\n")
    end
  end

  describe '#warning' do
    it 'logging warning' do
      logger = DesignPattern::Singleton::ModuleBasedLogger
      logger.level = DesignPattern::Singleton::ModuleBasedLogger::WARNING

      logger.warning('ユニットAE-35の故障が予測されました。')

      expect(log_file).to exist
      expect(File.open(log_file).read).to eq("コンピュータがチェスゲームに勝ちました。\nユニットAE-35の故障が予測されました。\n")
    end
  end

  describe '#error' do
    it 'logging error' do
      logger = DesignPattern::Singleton::ModuleBasedLogger
      logger.level = DesignPattern::Singleton::ModuleBasedLogger::ERROR

      logger.error('HAL-9000 機能停止、緊急動作を実行します!')

      expect(log_file).to exist
      expect(File.open(log_file).read).to eq("コンピュータがチェスゲームに勝ちました。\nユニットAE-35の故障が予測されました。\nHAL-9000 機能停止、緊急動作を実行します!\n")
    end
  end

  after(:all) do
    log_file = Pathname.new('log2.txt')
    File.delete(log_file)
  end
end