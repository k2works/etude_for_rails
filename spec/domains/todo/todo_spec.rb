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
  end
end