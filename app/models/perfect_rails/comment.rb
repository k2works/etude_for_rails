# == Schema Information
#
# Table name: perfect_rails_comments
#
#  id           :integer          not null, primary key
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class PerfectRails::Comment < ApplicationRecord
  include PublishedScope

  concerning :PublishedScope do
    included do
      scope :not_published, -> { where(published_at: nil) }
    end
  end
end
