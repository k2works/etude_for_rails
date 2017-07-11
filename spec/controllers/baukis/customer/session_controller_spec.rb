require 'rails_helper'

describe Baukis::Customer::SessionsController do
  describe '#create' do
    let(:customer) { create(:customer, password: 'password')}

    example '「次回から自動でログインする」チェックせずにログイン' do
      post :create, params: {
          baukis_customer_login_form: {
          email: customer.email,
          password: 'password'
          }
      }

      expect(session[:customer_id]).to eq(customer.id)
      expect(response.cookies).not_to have_key('customer_id')
    end

    example '「次回から自動でログインする」にチェックしてログイン' do
      post :create, params: {
          baukis_customer_login_form: {
          email: customer.email,
          password: 'password',
          remember_me: '1'
          }
      }

      expect(session).not_to have_key(:customer_id)
      expect(response.cookies['customer_id']).to match(/[0-9a-f][40]\z/)
    end
  end
end