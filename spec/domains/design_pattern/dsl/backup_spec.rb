require 'rails_helper'
require 'pathname'
require 'fileutils'

describe DesignPattern::DSL::Backup do
  describe '#run' do
    it 'create backup' do
      data_source = DesignPattern::DSL::DataSource.new('spec/domains/design_pattern/dsl/data',DesignPattern::Interpreter::All.new)
      backup = DesignPattern::DSL::Backup.instance
      backup.data_sources << data_source
      this_backup_path = backup.backup_file

      expect(Pathname.new(this_backup_path)).to be_directory
      FileUtils.rm_rf(this_backup_path)
    end
  end
end