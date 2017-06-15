require 'rails_helper'

describe Todo::Command do
  before(:all) do
    Todo::DB.prepare
  end

  let!(:command) {Todo::Command.new(nil)}

  describe '#create_task' do
    it 'create task' do
      command.send(:create_task,'create_name', 'create_content')
      expect(Todo::Task.where(name:'create_name').count).to eq(1)
    end

    it 'validate name' do
      expect{command.send(:create_task,'', 'create_content')}.to raise_exception(ActiveRecord::RecordInvalid)
    end

    it 'validate content' do
      expect{command.send(:create_task,'create_name', '')}.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  describe '#update_task' do
    it 'update task' do
      task = command.send(:create_task,'create_name1', 'create_content1')
      command.send(:update_task,task.id, {content: 'sample1', status: 'done'})
      expect(command.send(:find_tasks,'done').exists?).to be_truthy
    end
  end

  describe '#delete_task' do
    it 'delete task' do
      task = command.send(:create_task,'create_name1', 'create_content1')
      command.send(:delete_task,task.id)
      expect(Todo::Task.where(name:'create_name1').count).to eq(0)
    end
  end
end