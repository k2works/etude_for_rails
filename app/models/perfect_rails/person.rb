class PerfectRails::Person
  include ActiveModel::Validations
  attr_accessor :name, :email

  validates :email, presence: true, email: true
end