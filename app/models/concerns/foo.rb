module Foo
  extend ActiveSupport::Concern

  module ClasssMethods
    def appended_class_method
      puts "追加されたクラスメソッド"
    end

    def appended_instance_method
      puts "追加されたインスタンスメッソド"
    end
  end
end

class Bar
  include Foo
end