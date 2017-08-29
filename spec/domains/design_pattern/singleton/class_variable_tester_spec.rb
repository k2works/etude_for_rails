require 'rails_helper'

describe DesignPattern::Singleton::ClassVariableTester do
  describe '#increment' do
    it 'count class variable and instance variable' do
      c1 = DesignPattern::Singleton::ClassVariableTester.new
      c1.increment
      c1.increment
      puts("c1: #{c1}")
      expect(c1.instance_variable_get(:@instance_count)).to eq(2)
      expect(DesignPattern::Singleton::ClassVariableTester.class_variable_get(:@@class_count)).to eq(2)


      c2 = DesignPattern::Singleton::ClassVariableTester.new
      puts("c2: #{c2}")
      expect(c2.instance_variable_get(:@instance_count)).to eq(0)
      expect(DesignPattern::Singleton::ClassVariableTester.class_variable_get(:@@class_count)).to eq(2)
    end
  end
end