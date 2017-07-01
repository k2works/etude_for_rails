# == Schema Information
#
# Table name: awesome_events_events
#
#  id          :integer          not null, primary key
#  owner_id    :integer
#  name        :string           not null
#  place       :string           not null
#  start_time  :datetime         not null
#  end_time    :datetime         not null
#  content     :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_image :string
#

require 'rails_helper'

RSpec.describe AwesomeEvents::Event, type: :model do
  describe '#rails?' do
    context '#nameが"Rails勉強会"のとき' do
      it 'true を返すこと' do
        event = create(:event, name: 'Rails勉強会')
        expect(event.rails?).to eq true
      end
    end

    context '#nameが"Ruby勉強会"のとき' do
      it 'false を返すこと' do
        event = create(:event, name: 'Ruby勉強会')
        expect(event.rails?).to eq false
      end
    end
  end

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
