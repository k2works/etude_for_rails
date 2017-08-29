require 'singleton'

module DesignPattern
  module DSL
    class Backup
      include ::Singleton

      attr_accessor :backup_directory, :interval
      attr_reader :data_sources

      def initialize
        @data_sources = []
        @backup_directory = 'spec/domains/design_pattern/dsl/backup'
        @interval = 60
      end

      def backup_file
        this_backup_dir = Time.new.ctime.tr(' :','_')
        this_backup_path = File.join(backup_directory, this_backup_dir)
        @data_sources.each {|source| source.backup(this_backup_path)}
        this_backup_path
      end

      def run
        while true
          backup_file
          sleep(@interval*60)
        end
      end
    end
  end
end
