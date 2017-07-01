require 'rails_helper'

RSpec.describe PerfectRails::BookCover, type: :model do
  describe '#plural' do
    let(:name) { PerfectRails::BookCover.model_name }
    it '文字列の変換を簡単に処理できる' do
      expect(name.plural).to eq "perfect_rails_book_covers"
      expect(name.i18n_key).to eq :"perfect_rails/book_cover"
      expect(name.to_s).to eq "PerfectRails::BookCover"
      expect(name.human).to eq "Book cover"
    end
  end
end