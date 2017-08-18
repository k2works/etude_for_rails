require 'rails_helper'

describe DesignPattern::Composite::CompositeTask do
  describe '#add_sub_task' do
    it 'add sub task' do
      composite = DesignPattern::Composite::CompositeTask.new('example')
      composite.add_sub_task(DesignPattern::Composite::AddDryIngredientsTask.new)
      expect(composite.instance_variable_get(:@sub_tasks).first).to be_an_instance_of(DesignPattern::Composite::AddDryIngredientsTask)
    end
  end

  describe '#remove_sub_task' do
    it 'remove sub task' do
      composite = DesignPattern::Composite::CompositeTask.new('example')
      task = DesignPattern::Composite::AddDryIngredientsTask.new
      composite.add_sub_task(task)
      composite.remove_sub_task(task)
      expect(composite.instance_variable_get(:@sub_tasks)).to be_empty
    end
  end

  describe '#get_time_required' do
    it 'return sum of require times' do
      composite = DesignPattern::Composite::CompositeTask.new('example')
      task = DesignPattern::Composite::AddDryIngredientsTask.new
      composite.add_sub_task(task)
      task = DesignPattern::Composite::AddLiquidsTask.new
      composite.add_sub_task(task)
      expect(composite.get_time_required).to eq(11.0)
    end
  end
end