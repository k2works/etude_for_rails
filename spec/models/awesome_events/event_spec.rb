require 'rails_helper'

RSpec.describe AwesomeEvents::Event, type: :model do
  describe '#name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end

  describe '#created_by?' do
    let(:event) { create(:event) }
    subject { event.created_by?(user) }

    context '引数がnilなとき' do
      let(:user) { nil }
      it { should be_falsey }
    end

    context '#owner_idと引数の#idが同じとき' do
      # eventのowner_idがnilだけと関連はある
      let(:user) { double('user', id: event.id) }
      it { expect(event.owner).not_to be_nil }
    end
  end
end
