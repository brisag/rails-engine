require 'rails_helper'
RSpec.describe Merchant do
  describe 'relationhips' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'class methods methods' do
    before :each do
      @merchant = create(:merchant, name: "one")
      @item1 = create(:item, merchant_id: @merchant.id)
      @item2 = create(:item, merchant_id: @merchant.id)
      @invoice1 = create(:invoice, merchant_id: @merchant.id, status: 'shipped')
      @invoice2 = create(:invoice, merchant_id: @merchant.id, status: 'shipped')
      @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 10)
      @invoice_items2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 20)
      @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: 'success')
      @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: 'success')

      @merchant2 = create(:merchant, name: "two")
      @item3 = create(:item, merchant_id: @merchant2.id)
      @item4 = create(:item, merchant_id: @merchant2.id)
      @invoice3 = create(:invoice, merchant_id: @merchant2.id, status: 'shipped')
      @invoice4 = create(:invoice, merchant_id: @merchant2.id, status: 'shipped')
      @invoice_items3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice3.id, quantity: 10, unit_price: 25)
      @invoice_items4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, quantity: 10, unit_price: 30)
      @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: 'success')
      @transaction4 = create(:transaction, invoice_id: @invoice4.id, result: 'success')

      @merchant3 = create(:merchant, name: "three")
      @item5 = create(:item, merchant_id: @merchant3.id)
      @item6 = create(:item, merchant_id: @merchant3.id)
      @invoice5 = create(:invoice, merchant_id: @merchant3.id, status: 'shipped')
      @invoice6 = create(:invoice, merchant_id: @merchant3.id, status: 'shipped')
      @invoice_items5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, quantity: 10, unit_price: 40)
      @invoice_items6 = create(:invoice_item, item_id: @item6.id, invoice_id: @invoice6.id, quantity: 10, unit_price: 50)
      @transaction5 = create(:transaction, invoice_id: @invoice5.id, result: 'success')
      @transaction6 = create(:transaction, invoice_id: @invoice6.id, result: 'success')

      @merchant4 = create(:merchant, name: "four")
      @item7 = create(:item, merchant_id: @merchant4.id)
      @item8 = create(:item, merchant_id: @merchant4.id)
      @invoice7 = create(:invoice, merchant_id: @merchant4.id, status: 'shipped')
      @invoice8 = create(:invoice, merchant_id: @merchant4.id, status: 'shipped')
      @invoice_items7 = create(:invoice_item, item_id: @item7.id, invoice_id: @invoice7.id, quantity: 10, unit_price: 60)
      @invoice_items8 = create(:invoice_item, item_id: @item8.id, invoice_id: @invoice8.id, quantity: 10, unit_price: 65)
      @transaction7 = create(:transaction, invoice_id: @invoice7.id, result: 'success')
      @transaction8 = create(:transaction, invoice_id: @invoice8.id, result: 'success')
    end

    describe "::merchants_with_most_revenue" do
      it "finds merchants with most revenue" do

        merchants = Merchant.merchants_with_most_revenue(3)
        expect(merchants.to_a).to eq([@merchant4, @merchant3, @merchant2])

        # expect(merchants.first.revenue.to_f).to eq(29.97)
      end
    end
  end


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
