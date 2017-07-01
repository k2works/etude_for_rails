class CreateTodoTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :todo_tasks,comment:'タスク' do |t|
      t.string :name, null:false, comment:'名前'
      t.text :content, null:false, comment: '内容'
      t.integer :status, default:0, null:false, comment: 'ステータス 0:NOT_YET 1:DONE 2:PENDING'

      t.timestamps
    end
  end
end
