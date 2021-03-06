module PublishedScope
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where.not(published_at: nil) }
  end
end
