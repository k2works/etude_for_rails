require 'rails_helper'

RSpec.describe PerfectRails::Person, type: :model do
  describe '#email' do
    let(:person) { PerfectRails::Person.new }

    context 'nilのとき' do
      it 'valid でないこと' do
        person.valid?
        expect(person.errors[:email]).to be_present
      end
    end

    context '間違ったフォーマットのとき' do
      it 'validでないこと' do
        person.email = 'notemailformat'
        person.valid?
        expect(person.errors[:email]).to be_present
      end
    end

    context '正しいフォーマットのとき' do
      it 'validであること' do
        person.email = 'email@example.com'
        person.valid?
        expect(person.errors[:email]).to be_blank
      end
    end
  end
end