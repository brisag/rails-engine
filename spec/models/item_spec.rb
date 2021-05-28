require 'rails_helper'
RSpec.describe Item do
  describe 'relationhips' do
    it { should belong_to :merchant }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  before :each do
    @merchant = create(:merchant)

    @item1 = create(:item, name: 'Turing', unit_price: 20000.00, merchant_id: @merchant.id)
    @item2 = create(:item, name: 'Ring Mart', unit_price: 120.00, merchant_id: @merchant.id)
    @item3 = create(:item, name: 'Wamart', unit_price: 50.00, merchant_id: @merchant.id)

    @invoice = create(:invoice, merchant_id: @merchant)
    @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice, quantity: 2, unit_price: 5.00)
  end

  describe 'class methods' do
    it '::search_criteria' do
      expect(Item.search_criteria('ring')).to eq([@item2, @item1])
    end

    it '::search_by_max_price' do
      expect(Item.search_by_max_price(60)).to eq(@item3)
    end

    it '::search_by_min_price' do
      expect(Item.search_by_min_price(1000)).to eq(@item1)
    end

    describe '::search_by_price' do
      it 'max and min price' do
        expect(Item.min_max_search(100, 200)).to eq(@item2)
      end

      it 'min price ony' do
        expect(Item.min_max_search(200, nil)).to eq(@item1)
      end

      it 'max price ony' do
        expect(Item.min_max_search(nil, 200)).to eq(@item2)
      end
    end
  end
end
