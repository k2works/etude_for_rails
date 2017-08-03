# == Schema Information
#
# Table name: baukis_allowed_sources # 許可IPアドレス
#
#  id         :integer          not null, primary key
#  namespace  :string(255)      not null                 # 名前空間
#  octet1     :integer          not null                 # 第１オクテット
#  octet2     :integer          not null                 # 第２オクテット
#  octet3     :integer          not null                 # 第３オクテット
#  octet4     :integer          not null                 # 第４オクテット
#  wildcard   :boolean          default(FALSE), not null # ワイルドカード
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  baukis_allowed_sources_on_namespace_and_octets  (namespace,octet1,octet2,octet3,octet4) UNIQUE
#

class Baukis::AllowedSource < ApplicationRecord
  attr_accessor :last_octet, :_destroy

  before_validation do
    if last_octet
      self.last_octet == '*'
      if last_octet == '*'
        self.octet4 = 0
        self.wildcard = true
      else
        self.octet4 = last_octet
      end
    end
  end

  validates :octet1, :octet2, :octet3, :octet4, presence: true, numericality: { only_integer: true, allow_blank: true }, inclusion: { in: 0..255, allow_blank: true }
  validates :octet4, uniqueness: { scope: [ :octet1, :octet2, :octet3 ], allow_blank: true }
  validates :last_octet, inclusion: { in: (0..255).to_a.map(&:to_s) + [ '*' ], allow_blank: true }

  after_validation do
    if last_octet
      errors[:octet4].each do |message|
        errors.add(:last_octet, message)
      end
    end
  end

  def ip_address=(ip_address)
    octets = ip_address.split('.')
    self.octet1 = octets[0]
    self.octet2 = octets[1]
    self.octet3 = octets[2]
    if octets[3] == '*'
      self.octet4 = 0
      self.wildcard = true
    else
      self.octet4 = octets[3]
    end
  end

  class << self
    def include?(namespace, ip_address)
      !Rails.application.config.baukis[:restrict_ip_addresses] ||
          where(namespace: namespace).where(options_for(ip_address)).exists?
    end

    private
    def options_for(ip_address)
      octets = ip_address.split('.')
      condition = %Q{octet1 = ? AND octet2 = ? AND octet3 = ? AND ((octet4 = ? AND wildcard = ?) OR wildcard = ?)}.gsub(/\s+/, ' ').strip
      [ condition, *octets, false, true ]
    end
  end
end
