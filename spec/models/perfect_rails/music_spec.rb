require 'rails_helper'

RSpec.describe PerfectRails::Music, type: :model do
  let(:music) { PerfectRails::Music.create(title: "Waltz for Debby") }

  describe '.create' do
    it '作成日も一緒に設定される' do
      expect(music.created_at).not_to be_nil
    end
  end

  describe '#play' do
    it '演奏タイトルが表示される' do
      expect{ music.play }.to output("created\nWaltz for Debby\nplayed\n").to_stdout
    end
  end
end
