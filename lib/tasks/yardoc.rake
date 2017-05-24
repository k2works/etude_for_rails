require 'yard'
require 'yard/rake/yardoc_task'

namespace :doc do
  YARD::Rake::YardocTask.new do |t|
    t.files = %w(
        app/models/**/*.rb
        app/controllers/**/*.rb
        app/helpers/**/*.rb
        app/mailers/**/*.rb
        lib/**/*.rb
      )
    t.options = []
    # t.options = %w(--debug --verbose) if $trace
  end
end