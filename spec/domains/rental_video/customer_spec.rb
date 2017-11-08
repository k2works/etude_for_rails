require 'rails_helper'
include RentalVideo

def rental_movie(days_rented, price)
  mv = RentalVideo::Movie.new('Attack of the Killer Tomatoes!', price)
  RentalVideo::Rental.new(mv, days_rented)
end

describe RentalVideo::Customer do
  let(:customer) { RentalVideo::Customer.new('Taro') }
  describe '#add_rental' do
    it 'should be rented' do
      customer.add_rental(rental_movie(7, RentalVideo::ChildrenPrice.new))
      expect(customer.instance_variable_get :@rentals).not_to be_empty
    end
  end

  describe '#statement' do
    context 'regular' do
      context 'rental a week' do
        days_rented = 7
        it 'calculate price' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::RegularPrice.new))
          expect(customer.statement).to be_include '9.5'
        end

        it 'earned frequent renter points' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::RegularPrice.new))
          expect(customer.statement).to be_include '1'
        end

        it 'print statement' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::RegularPrice.new))
          expect(customer.statement).to be_match 'Rental Record for Taro\n\tAttack of the Killer Tomatoes!\t9.5\nAmount owed is 9.5\nYou earned 1 frequent renter points'
        end
      end

      context 'rental 2 days' do
        days_rented = 2
        it 'calculate price' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::RegularPrice.new))
          expect(customer.statement).to be_include '2'
        end

        it 'earned frequent renter points' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::RegularPrice.new))
          expect(customer.statement).to be_include '1'
        end

        it 'print statement' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::RegularPrice.new))
          expect(customer.statement).to be_match 'Rental Record for Taro\n\tAttack of the Killer Tomatoes!\t2\nAmount owed is 2\nYou earned 1 frequent renter points'
        end
      end
    end

    context 'new release' do
      context 'rental a week' do
        days_rented = 7
        it 'calculate price' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::NewReleasePrice.new))
          expect(customer.statement).to be_include '21'
        end

        it 'earned frequent renter points' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::NewReleasePrice.new))
          expect(customer.statement).to be_include '2'
        end

        it 'print statement' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::NewReleasePrice.new))
          expect(customer.statement).to be_match 'Rental Record for Taro\n\tAttack of the Killer Tomatoes!\t21\nAmount owed is 21\nYou earned 2 frequent renter points'
        end
      end

      context 'rental 3 days' do
        days_rented = 3
        it 'calculate price' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::NewReleasePrice.new))
          expect(customer.statement).to be_include '9'
        end

        it 'earned frequent renter points' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::NewReleasePrice.new))
          expect(customer.statement).to be_include '2'
        end

        it 'print statement' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::NewReleasePrice.new))
          expect(customer.statement).to be_match 'Rental Record for Taro\n\tAttack of the Killer Tomatoes!\t9\nAmount owed is 9\nYou earned 2 frequent renter points'
        end
      end

      context 'rental a day' do
        days_rented = 1
        it 'calculate price' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::NewReleasePrice.new))
          expect(customer.statement).to be_include '3'
        end

        it 'earned frequent renter points' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::NewReleasePrice.new))
          expect(customer.statement).to be_include '1'
        end

        it 'print statement' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::NewReleasePrice.new))
          expect(customer.statement).to be_match 'Rental Record for Taro\n\tAttack of the Killer Tomatoes!\t3\nAmount owed is 3\nYou earned 1 frequent renter points'
        end
      end
    end

    context 'children' do
      context 'rental a week' do
        days_rented = 7
        it 'calculate price' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::ChildrenPrice.new))
          expect(customer.statement).to be_include '7.5'
        end

        it 'earned frequent renter points' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::ChildrenPrice.new))
          expect(customer.statement).to be_include '1'
        end

        it 'print statement' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::ChildrenPrice.new))
          expect(customer.statement).to be_match 'Rental Record for Taro\n\tAttack of the Killer Tomatoes!\t7.5\nAmount owed is 7.5\nYou earned 1 frequent renter points'
        end
      end

      context 'rental 3 days' do
        days_rented = 3
        it 'calculate price' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::ChildrenPrice.new))
          expect(customer.statement).to be_include '1.5'
        end

        it 'earned frequent renter points' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::ChildrenPrice.new))
          expect(customer.statement).to be_include '1'
        end

        it 'print statement' do
          customer.add_rental(rental_movie(days_rented, RentalVideo::ChildrenPrice.new))
          expect(customer.statement).to be_match 'Rental Record for Taro\n\tAttack of the Killer Tomatoes!\t1.5\nAmount owed is 1.5\nYou earned 1 frequent renter points'
        end
      end
    end
  end

  describe '#html_statement' do
    it 'print html format statement' do
      days_rented = 7
      customer.add_rental(rental_movie(days_rented, RentalVideo::RegularPrice.new))
      expect(customer.html_statement).to be_match '<h1>Rental Record for <em>Taro</em></h1></p>\n\tAttack of the Killer Tomatoes!\t9.5<br>\n<p>You owed is <em>9.5</em><p>\nOn this rental you earned <em>1</em> frequent renter points<p>'
    end    
  end  
end