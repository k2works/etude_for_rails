require 'rails_helper'

describe DesignPattern::Iterator::ArrayIterator do
  describe '#next_item' do
    it 'iterate array items' do
      array = ['red', 'green', 'blue']
      i = DesignPattern::Iterator::ArrayIterator.new(array)
      while i.has_next?
        expect(i.next_item).to match(/red|green|blue/)
      end
    end

    it 'iterate string items' do
      i = DesignPattern::Iterator::ArrayIterator.new('abc')
      while i.has_next?
        expect(i.next_item).to match(/[abc]/)
      end
    end
  end

  describe '#for_each_element' do
    it 'iterate array items'do
      a = [10, 20, 30]

      i = lambda do
        DesignPattern::Iterator::ArrayIterator.for_each_element(a) do |element|
          puts("The element is #{element}")
        end
      end

      i2 = lambda { a.each {|element| puts("The element is #{element}")} }

      expected = <<-EOS
The element is 10
The element is 20
The element is 30
      EOS

      expect { i.call }.to output(expected).to_stdout
      expect { i2.call }.to output(expected).to_stdout
    end
  end
end
