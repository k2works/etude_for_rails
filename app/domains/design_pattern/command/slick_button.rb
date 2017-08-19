# frozen_string_literal: true

module DesignPattern
  module Command
    class SlickButton
      attr_accessor :command

      def initialize(command)
        @command = command
      end

      #
      # ボタンの描画と管理のためのコード
      # コードを省略
      #

      def on_button_push
        @command.execute if @command
      end
    end
  end
end
