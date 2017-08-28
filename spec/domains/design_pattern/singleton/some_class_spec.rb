require 'rails_helper'

describe DesignPattern::Singleton::SomeClass do
  describe '.class_level_method' do
    it 'print message' do
      print = lambda {DesignPattern::Singleton::SomeClass.class_level_method}
      expect{ print.call }.to output("hello from the class method\n").to_stdout
    end
  end

  describe '.class_level_method2' do
    it 'print message' do
      print = -> {DesignPattern::Singleton::SomeClass.class_level_method2}
      expect{ print.call }.to output("hello from the class method2\n").to_stdout
    end
  end
end