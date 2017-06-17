class Todo::TasksController < ApplicationController
  before_action :set_todo_task, only: [:show, :edit, :update, :destroy]
  before_action :prepare

  # GET /todo/tasks
  # GET /todo/tasks.json
  def index
    @todo_tasks = Todo::Task.order('created_at DESC')
    if @status = params[:status]
      case @status
        when 'not_yet'
          @todo_tasks = @todo_tasks.status_is_not_yet
        when 'done'
          @todo_tasks = @todo_tasks.status_is_done
        when 'pending'
          @todo_tasks = @todo_tasks.status_is_pending
        else
          @status = nil
      end
    end
  end

  # GET /todo/tasks/1
  # GET /todo/tasks/1.json
  def show
  end

  # GET /todo/tasks/new
  def new
    @todo_task = Todo::Task.new
  end

  # GET /todo/tasks/1/edit
  def edit
  end

  # POST /todo/tasks
  # POST /todo/tasks.json
  def create
    @todo_task = Todo::Task.new(todo_task_params)

    respond_to do |format|
      if @todo_task.save
        format.html { redirect_to @todo_task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @todo_task }
      else
        format.html { render :new }
        format.json { render json: @todo_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo/tasks/1
  # PATCH/PUT /todo/tasks/1.json
  def update
    respond_to do |format|
      if @todo_task.update(todo_task_params)
        format.html { redirect_to @todo_task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo_task }
      else
        format.html { render :edit }
        format.json { render json: @todo_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo/tasks/1
  # DELETE /todo/tasks/1.json
  def destroy
    @todo_task.destroy
    respond_to do |format|
      format.html { redirect_to todo_tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_todo_task
    @todo_task = Todo::Task.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def todo_task_params
    params.require(:todo_task).permit(:name, :content, :status)
  end

  def prepare
    Todo::DB.prepare
  end
end
