module Todo
  # コマンドラインベースの処理を行うクラスです
  # @author k2works
  class Command

    def execute
      DB.prepare
    end

    def create_task(name, content)
      # タスク作成時のstatusはデフォルト値が使われNOT_YETとなる
      Task.create!(name: name, content: content).reload
    end
  end
end