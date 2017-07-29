module Baukis
  class CustomerMessage < Message
    scope :unprocessed, -> { where(status: 'new', deleted: false) }
  end
end