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

  describe '#password=' do
    example '文字列を与えると、hashed_passwordは長さ60の文字列になる' do
      member = Baukis::StaffMember.new
      member.password = 'baukis'
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    example 'nilを与えると、hashed_passwordはnilになる' do
      member = Baukis::StaffMember.new(hashed_password: 'x')
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end


  describe '値の正規化' do
    example 'email前後の空白を除去' do
      member = create(:staff_member, email: ' test@example.com')
      expect(member.email).to eq('test@example.com')
    end

    example 'email前後の全角スペースを除去' do
      member = create(:staff_member, email: "\u{3000}test@example.com\u{3000}")
      expect(member.email).to eq('test@example.com')
    end

    example 'family_name_kanaに含まれるひらがなをカタカナに変換' do
      member = create(:staff_member, family_name_kana: 'てすと')
      expect(member.family_name_kana).to eq('テスト')
    end

    example 'family_name_kanaに含まれる半角カナを全角カナに変換' do
      member = create(:staff_member, family_name_kana: 'ﾃｽﾄ')
      expect(member.family_name_kana).to eq('テスト')
    end
  end

  describe 'バリデーション' do
    example '@を２個含むemailは無効' do
      member = build(:staff_member, email: 'test@@examle.com')
      expect(member).not_to be_valid
    end

    example '漢字を含むfamily_name_kanaは無効' do
      member = build(:staff_member, family_name_kana: '試験')
      expect(member).not_to be_valid
    end

    example '長音符を含むfamily_name_kanaは有効' do
      memeber = build(:staff_member, family_name_kana: 'エリー')
    end

    example '他の職員のメールアドレスと重複したemailは無効' do
      member1 = create(:staff_member)
      member2 = build(:staff_member, email: member1.email)
      expect(member2).not_to be_valid
    end
  end
end