# == Schema Information
#
# Table name: baukis_staff_members
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  email_for_index  :string           not null
#  family_name      :string           not null
#  given_name       :string           not null
#  family_name_kana :string           not null
#  given_name_kana  :string           not null
#  hashed_password  :string
#  start_date       :date             not null
#  end_date         :date
#  suspended        :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Baukis::StaffMember, type: :model do
  describe '#email_for_index' do
    let(:staff_member) { create(:staff_member, email:'TEST@TEST.COM') }
    it '小文字に変換される' do
      expect(staff_member.email_for_index).to eq 'test@test.com'
    end
  end
end
