require 'rails_helper'
RSpec.describe Merchant do
  describe 'relationhips' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  # describe 'class methods methods' do
  # end

  describe 'instance methods' do
    before :each do
      @merchant = create(:merchant)

      @item1 = create(:item, merchant_id: @merchant.id)
      @item2 = create(:item, merchant_id: @merchant.id)
      @item3 = create(:item, merchant_id: @merchant.id)
      @item4 = create(:item, merchant_id: @merchant.id)

      @invoice1 = create(:invoice, merchant_id: @merchant.id, status: 'shipped')
      @invoice2 = create(:invoice, merchant_id: @merchant.id, status: 'shipped')
      @invoice3 = create(:invoice, merchant_id: @merchant.id, status: 'pending')

      @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 11, unit_price: 10.12)
      @invoice_items2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id, quantity: 24, unit_price: 2)
      @invoice_items3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 313.0)
      @invoice_items4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice3.id, quantity: 9, unit_price: 0.10)

      @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: 'success')
      @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: 'success')
      @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: 'success')
    end

    describe 'revenue' do
      it 'multiplies the invoice item and unit price for a transaction' do
        expect(@merchant.revenue).to eq(1098.32)
      end
    end
  end
end
