# == Schema Information
#
# Table name: baukis_allowed_sources
#
#  id         :integer          not null, primary key
#  namespace  :string           not null
#  octet1     :integer          not null
#  octet2     :integer          not null
#  octet3     :integer          not null
#  octet4     :integer          not null
#  wildcard   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Baukis::AllowedSource, type: :model do
  describe '#ip_address=' do
    example '引数に"127.0.0.1"を与えた場合' do
      src = Baukis::AllowedSource.new(namespace: 'staff', ip_address:'127.0.0.1')
      expect(src.octet1).to eq(127)
      expect(src.octet2).to eq(0)
      expect(src.octet3).to eq(0)
      expect(src.octet4).to eq(1)
      expect(src).not_to be_wildcard
      expect(src).to be_valid
    end

    example '引数に"192.168.0.*"を与えた場合' do
      src = Baukis::AllowedSource.new(namespace: 'staff', ip_address: '192.168.0.*')
      expect(src.octet1).to eq(192)
      expect(src.octet2).to eq(168)
      expect(src.octet3).to eq(0)
      expect(src.octet4).to eq(0)
      expect(src).to be_wildcard
      expect(src).to be_valid
    end

    example '引数に不正な文字列を与えた場合' do
      src = Baukis::AllowedSource.new(namespace: 'staff', ip_address: 'A.B.C.D')
      expect(src).not_to be_valid
    end
  end

  describe '.include?' do
    before do
      Rails.application.config.baukis[:restrict_ip_addresses ] = true
      Baukis::AllowedSource.create!(namespace: 'staff', ip_address: '127.0.0.1')
      Baukis::AllowedSource.create!(namespace: 'staff', ip_address: '192.168.0.*')
    end

    example 'マッチしない場合' do
      expect(Baukis::AllowedSource.include?('staff','192.168.1.1')).to be_falsey
    end

    example '全オクテットがマッチする場合' do
      expect(Baukis::AllowedSource.include?('staff', '127.0.0.1')).to be_truthy
    end

    example '*付きのAllowedSourceにマッチする場合' do
      expect(Baukis::AllowedSource.include?('staff', '192.168.0.100')).to be_truthy
    end
  end
end
