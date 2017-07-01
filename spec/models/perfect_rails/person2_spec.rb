require 'rails_helper'

RSpec.describe PerfectRails::Person2, type: :model do
  let(:person) { PerfectRails::Person2.new }

  describe '#name' do
    it '名前が入る' do
      person.name = 'Art Blakey'
      expect(person.name).to eq 'Art Blakey'
    end
  end

  describe '#name_contrived?' do
    it 'trueを返す' do
      expect(person.name_contrived?).to be_truthy
    end
  end

  describe '#clear_name' do
    it '名前が消される' do
      expect(person.clear_name).to be_nil
    end
  end

  describe '#rest_name_to_default!' do
    it '名前がデフォルトにもどる' do
      expect(person.reset_name_to_default!).to eq('Default Name')
    end
  end
end