# == Schema Information
#
# Table name: perfect_rails_comments
#
#  id           :integer          not null, primary key
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe PerfectRails::Comment, type: :model do
  describe '.published' do
    context 'published_at' do
      context 'nilのとき' do
        it '該当なし' do
          create(:comment, published_at:nil)
          expect(PerfectRails::Comment.published.count).to eq 0
        end
      end

      context 'nilでないとき' do
        it '該当あり' do
          create(:comment)
          expect(PerfectRails::Comment.published.count).not_to eq 0
        end
      end
    end
  end

  describe '.not_published' do
    context 'published_at' do
      context 'nilのとき' do
        it '該当あり' do
          create(:comment, published_at:nil)
          expect(PerfectRails::Comment.not_published.count).to eq 1
        end
      end

      context 'nilでないとき' do
        it '該当なし' do
          create(:comment)
          expect(PerfectRails::Comment.not_published.count).not_to eq 1
        end
      end
    end
  end
end
