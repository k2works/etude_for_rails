require 'rails_helper'

RSpec.describe PerfectRails::Book, type: :model do
  describe '#title' do
    it { should validate_presence_of(:title) }
  end

  describe '#author' do
    it { should validate_presence_of(:author) }
  end

  describe '#published_year' do
    let(:book) { PerfectRails::Book.new }

    before(:each) do
      book.title = 'タイトル'
      book.author = '著者'
    end

    context 'nilのとき' do
      it 'validではない' do
        book.valid?
        expect(book.errors[:published_year]).to be_present
      end
    end

    context '数値が入力されたとき' do
      it 'validである' do
        book.published_year = 2100
        book.valid?
        expect(book.published_year).to eq Time.now.year
      end
    end

    context '文字が入力されたとき' do
      it 'validである' do
        book.published_year = '二千年'
        book.valid?
        expect(book.published_year).to eq Time.now.year
      end
    end
  end
end