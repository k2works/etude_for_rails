module Todo
  # コマンドラインベースの処理を行うクラスです
  # @author k2works
  class Command

    def self.run(argv)
      new(argv).execute
    end

    def initialize(argv=nil)
      @argv = argv
    end

    def execute
      options = Options.parse!(@argv) unless @argv.nil?

      DB.prepare
    end

    def create_task(name, content)
      # タスク作成時のstatusはデフォルト値が使われNOT_YETとなる
      Task.create!(name: name, content: content).reload
    end

    def delete_task(id)
      task = Task.find(id)
      task.destroy
    end

    def update_task(id, attributes)
      if status_name = attributes[:status]
        attributes[:status] = Task::STATUS.fetch(status_name.upcase)
      end

      task = Task.find(id)
      task.update_attributes! attributes

      task.reload
    end

    def find_tasks(status_name)
      all_tasks = Task.order('created_at DESC')

      if status_name
        status = Task::STATUS.fetch(status_name.upcase)
        all_tasks.status_is(status)
      else
        all_tasks
      end
    end
  end
end