module DesignPattern
  module Adapter
    class Renderer
      def render(text_object)
        text = text_object.text
        size = text_object.size_inches
        color = text_object.color

        puts("Text is #{text}")
        puts("#{size} inch")
        puts("Color is #{color}")
      end
    end
  end
end