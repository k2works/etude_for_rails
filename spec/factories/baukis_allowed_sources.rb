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

FactoryGirl.define do
  factory :baukis_allowed_source, class: 'Baukis::AllowedSource' do
    
  end
end
