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
end
