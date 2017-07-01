# == Schema Information
#
# Table name: perfect_rails_schedules
#
#  id          :integer          not null, primary key
#  room_id     :integer
#  finished_at :datetime
#  started_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe PerfectRails::Schedule, type: :model do
  describe '#MustNotOverlapValidator' do
    context '開始日と終了日が重なっているとき' do
      let(:room) { create(:room)}
      let(:schedule) { create(:schedule, room_id:room.id, started_at:Date.today, finished_at:Date.today)}
      let(:overlap) { build(:schedule,room_id:room.id, started_at:Date.today - 1, finished_at:Date.today + 1)}
      it 'validでないこと' do
        schedule.valid?
        overlap.valid?
        expect(overlap.errors[:base]).to be_present
      end
    end

    context '開始日と終了日が重なっていないとき' do
      let(:room) { create(:room)}
      let(:schedule) { create(:schedule, room_id:room.id, started_at:Date.today, finished_at:Date.today)}
      let(:not_overlap) { build(:schedule,room_id:room.id, started_at:Date.today + 1, finished_at:Date.today - 1)}
      it 'validであること' do
        schedule.valid?
        not_overlap.valid?
        expect(not_overlap.errors[:base]).to be_blank
      end
    end
  end
end
