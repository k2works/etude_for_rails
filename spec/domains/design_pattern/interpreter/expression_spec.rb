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
  end
end