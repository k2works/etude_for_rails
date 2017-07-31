# == Schema Information
#
# Table name: baukis_tags # タグ
#
#  id    :integer          not null, primary key
#  value :string(255)      not null              # 値
#
# Indexes
#
#  index_baukis_tags_on_value  (value) UNIQUE
#

class Baukis::Tag < ApplicationRecord
end
