require_relative '../../../../app/domains/design_pattern/interpreter/expression.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/all.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/and.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/bigger.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/file_name.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/not.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/or.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/writable.rb'

def backup(dir, find_expression= DesignPattern::Interpreter::All.new)
  puts "Backup called, source dir=#{dir} find expr=#{find_expression}"
end

def to(backup_directory)
  puts "To called, backup dir=#{backup_directory}"
end

def interval(minutes)
  puts "Interval called, interval = #{minutes} minutes"
end

eval(File.read('backup.pr'))