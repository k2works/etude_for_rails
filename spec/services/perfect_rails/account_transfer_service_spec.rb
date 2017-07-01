require 'rails_helper'

RSpec.describe PerfectRails::AccountTransferService do
  let(:from) { create(:account)}
  let(:to) { create(:account)}

  describe '#transfer' do
    context '通貨が同じとき' do
      context '移動金額が移動元口座金額の範囲内のとき' do
        it '口座金額は移動する' do
          transfered_money = PerfectRails::Money.new(1,'JPY')
          account_transfer_service = PerfectRails::AccountTransferService.new(from, to)
          account_transfer_service.transfer(transfered_money)
          expect(from.amount).to eq 0
          expect(to.amount).to eq 2
        end
      end

      context '移動金額が移動元口座金額の範囲外のとき' do
        it '口座金額は移動しない' do
          transfered_money = PerfectRails::Money.new(10,'JPY')
          account_transfer_service = PerfectRails::AccountTransferService.new(from, to)
          expect { account_transfer_service.transfer(transfered_money) }.to raise_exception 'Other money is bigger than self'
        end
      end
    end

    context '通貨が違うとき' do
      let(:transfered_money){ PerfectRails::Money.new(1,'USD') }

      it '口座金額は移動しない' do
        account_transfer_service = PerfectRails::AccountTransferService.new(from, to)
        expect { account_transfer_service.transfer(transfered_money) }.to raise_exception 'Currency is different'
      end
    end
  end
end