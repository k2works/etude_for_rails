require_relative '../../../../app/domains/design_pattern/interpreter/expression.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/all.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/and.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/bigger.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/file_name.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/not.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/or.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/writable.rb'
require_relative '../../../../app/domains/design_pattern/dsl/backup.rb'
require_relative '../../../../app/domains/design_pattern/dsl/data_source.rb'
include DesignPattern::DSL

def backup(dir, find_expression= DesignPattern::Interpreter::All.new)
  Backup.instance.data_sources << DataSource.new(dir, find_expression)
end

def to(backup_directory)
  Backup.instance.backup_directory = backup_directory
end

def interval(minutes)
  Backup.instance.interval = minutes
end

eval(File.read('backup.pr'))
Backup.instance.run