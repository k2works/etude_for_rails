require 'rails_helper'

describe Todo::Command do
  before(:all) do
    Todo::Command.new.execute
  end

  let!(:command) {Todo::Command.new}

  describe '#create_task' do
    it 'create task' do
      command.create_task('create_name', 'create_content')
      expect(Todo::Task.where(name:'create_name').count).to eq(1)
    end

    it 'validate name' do
      expect{(command.create_task('', 'create_content'))}.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it 'validate content' do
      expect{(command.create_task('create_name', ''))}.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  describe '#update_task' do
    it 'update task' do
      task = command.create_task('create_name1', 'create_content1')
      command.update_task(task.id, {content: 'sample1', status: 'done'})
      expect(command.find_tasks('done').exists?).to be_truthy
    end

    it 'delete task' do
      task = command.create_task('create_name1', 'create_content1')
      command.delete_task(task.id)
      expect(command.find_tasks('not_yet').exists?).to be_falsey
    end
  end
end