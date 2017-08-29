require 'rails_helper'
require 'pathname'

describe DesignPattern::Interpreter::Expression do
  describe '#evaluate' do
    it 'find all files' do
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      expr_all = DesignPattern::Interpreter::All.new
      file = expr_all.evaluate(path.to_s)
      expect(file).to include("#{path.to_s}/expression_spec.rb")
    end

    it 'find file by name' do
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      expr_spec = DesignPattern::Interpreter::FileName.new('*_spec.rb')
      file = expr_spec.evaluate(path.to_s)
      expect(file).to include("#{path.to_s}/expression_spec.rb")
    end

    it 'find file by size' do
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      expr_file_size = DesignPattern::Interpreter::Bigger.new(900)
      file = expr_file_size.evaluate(path.to_s)
      expect(file).to include("#{path.to_s}/expression_spec.rb")
    end

    it 'find writable file' do
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      expr_file_writable = DesignPattern::Interpreter::Writable.new
      file = expr_file_writable.evaluate(path.to_s)
      expect(file).to include("#{path.to_s}/expression_spec.rb")
    end
  end
end