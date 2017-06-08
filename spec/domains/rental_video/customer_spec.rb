require 'rails_helper'
include RentalVideo

def rental_movie(days_rented, price_code)
  mv = RentalVideo::Movie.new('Attack of the Killer Tomatoes!', price_code)
  RentalVideo::Rental.new(mv, days_rented)
end

describe RentalVideo::Customer do
  let(:customer) {Customer.new('Taro')}
  describe '#add_rental' do
    it 'should be rented' do
      customer.add_rental(rental_movie(7, RentalVideo::Movie::REGULAR))
      expect(customer.instance_variable_get :@rentals).not_to be_empty
    end
  end

  describe '#statement' do
    it 'calculate price' do
      customer.add_rental(rental_movie(7,RentalVideo::Movie::REGULAR))
      expect(customer.statement).to be_include '9.5'
    end

    it 'print statement' do
      customer.add_rental(rental_movie(7,RentalVideo::Movie::REGULAR))
      expect(customer.statement).to be_match 'Rental Record for Taro\n\tAttack of the Killer Tomatoes!\t9.5\nAmount owed is 0.0\nYou earned 1 frequent renter points'
    end
  end
end