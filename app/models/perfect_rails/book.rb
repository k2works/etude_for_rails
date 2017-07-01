class PerfectRails::Book
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :title, :author, :published_year

  validates_presence_of :title, :author

  validates :published_year, numericality: true, inclusion: {in: 1900..2100}

  before_validation :ensure_published_year

  private

  def ensure_published_year
    self.published_year = Time.now.year if published_year
  end
end