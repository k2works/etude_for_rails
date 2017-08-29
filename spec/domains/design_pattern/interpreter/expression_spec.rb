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

    it 'find file by name using not' do
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      expr_spec = DesignPattern::Interpreter::FileName.new('*_spec.rb')
      not_spec_expr = DesignPattern::Interpreter::Not.new(expr_spec)
      file = not_spec_expr.evaluate(path.to_s)
      expect(file).not_to include("#{path.to_s}/expression_spec.rb")
    end

    it 'find file by size using not' do
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      expr_file_size = DesignPattern::Interpreter::Bigger.new(10000)
      small_expr = DesignPattern::Interpreter::Not.new(expr_file_size)
      file = small_expr.evaluate(path.to_s)
      expect(file).to include("#{path.to_s}/expression_spec.rb")
    end

    it 'find file by name or size' do
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      expr_file_size = DesignPattern::Interpreter::Bigger.new(10000)
      expr_spec = DesignPattern::Interpreter::FileName.new('*_spec.rb')
      big_or_spec_expr = DesignPattern::Interpreter::Or.new(expr_file_size, expr_spec)
      file = big_or_spec_expr.evaluate(path.to_s)
      expect(file).to include("#{path.to_s}/expression_spec.rb")
    end

    it 'find file by name and size' do
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      expr_file_size = DesignPattern::Interpreter::Bigger.new(1000)
      expr_spec = DesignPattern::Interpreter::FileName.new('*_spec.rb')
      big_and_spec_expr = DesignPattern::Interpreter::And.new(expr_file_size, expr_spec)
      file = big_and_spec_expr.evaluate(path.to_s)
      expect(file).to include("#{path.to_s}/expression_spec.rb")
    end

    it 'find file using operator' do
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      expr = (DesignPattern::Interpreter::Bigger.new(1000) & DesignPattern::Interpreter::Not.new(DesignPattern::Interpreter::Writable.new)) | DesignPattern::Interpreter::FileName.new("*_spec.rb")
      file = expr.evaluate(path.to_s)
      expect(file).to include("#{path.to_s}/expression_spec.rb")
    end

    it 'find file using operator' do
      ex = DesignPattern::Interpreter::Expression.new
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      expr = (ex.bigger(1000) & ex.except(ex.writable)) | ex.name("*_spec.rb")
      file = expr.evaluate(path.to_s)
      expect(file).to include("#{path.to_s}/expression_spec.rb")
    end
  end
end