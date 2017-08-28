require 'singleton'
module DesignPattern
  module Singleton
    class SingletonLogger < SimpleLogger
      include ::Singleton
    end
  end
end