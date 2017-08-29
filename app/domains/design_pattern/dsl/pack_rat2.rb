require 'singleton'
require_relative '../../../../app/domains/design_pattern/interpreter/expression.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/all.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/and.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/bigger.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/file_name.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/not.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/or.rb'
require_relative '../../../../app/domains/design_pattern/interpreter/writable.rb'
require_relative '../../../../app/domains/design_pattern/dsl/backup2.rb'
require_relative '../../../../app/domains/design_pattern/dsl/data_source.rb'

module DesignPattern
  module DSL
    class PackRat2
      include ::Singleton

      def initialize
        @backups = []
      end

      def register_backup(backup)
        @backups << backup
      end

      def run
        threads = []
        @backups.each do |backup|
          threads << Thread.new { backup.run }
        end
        threads.each {|t| t.join}
      end
    end
  end
end

eval(File.read('backup2.pr'))
DesignPattern::DSL::PackRat2.instance.run
