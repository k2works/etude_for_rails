require 'rails_helper'
require 'pathname'

describe DesignPattern::Interpreter::Parser do
  describe '#expression' do
    it 'find file which is bigger 1024 and filename *_spec. and writable' do
      path = Pathname.new('./spec/domains/design_pattern/interpreter')
      parser = DesignPattern::Interpreter::Parser.new "and (and(bigger 1024)(filename *_spec.rb)) writable"
      ast = parser.expression
      expect(ast.evaluate(path.to_s)).to include("#{path.to_s}/expression_spec.rb")
    end
  end
end