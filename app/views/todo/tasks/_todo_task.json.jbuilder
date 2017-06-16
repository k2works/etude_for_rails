json.extract! todo_task, :id, :name, :content, :status, :created_at, :updated_at
json.url todo_task_url(todo_task, format: :json)
