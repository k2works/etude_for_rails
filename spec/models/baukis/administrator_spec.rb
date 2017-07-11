# == Schema Information
#
# Table name: baukis_administrators
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  email_for_index :string           not null
#  hashed_password :string
#  suspended       :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Baukis::Administrator, type: :model do
  describe '#email_for_index' do
    let(:administrator) { create(:administrator, email:'TEST@TEST.COM') }
    it '小文字に変換される' do
      expect(administrator.email_for_index).to eq 'test@test.com'
    end
  end

  describe '#password=' do
    example '文字列を与えると、hashed_passwordは長さ60の文字列になる' do
      member = Baukis::Administrator.new
      member.password = 'baukis'
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    example 'nilを与えると、hashed_passwordはnilになる' do
      member = Baukis::Administrator.new(hashed_password: 'x')
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end

end
