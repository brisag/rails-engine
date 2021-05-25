require 'rails_helper'
RSpec.describe 'Revenue::MerchantController Show', type: :request do
  before :each do
    @merchant = create(:merchant, name: "name")
    @customer = create(:customer)

    @item1 = create(:item, merchant_id: @merchant.id)
    @item2 = create(:item, merchant_id: @merchant.id)
    @item3 = create(:item, merchant_id: @merchant.id)
    @item4 = create(:item, merchant_id: @merchant.id)

    @invoice1 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id, status: 'shipped')
    @invoice2 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id, status: 'shipped')
    @invoice3 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id, status: 'shipped')
    @invoice4 = create(:invoice, customer_id: @customer.id, merchant_id: @merchant.id, status: 'shipped')

    @invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 20.00)
    @invoice_item2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 30.00)
    @invoice_item3 = create(:invoice_item, item_id: @item3.id, invoice_id: @invoice3.id, quantity: 10, unit_price: 40.00)
    @invoice_item4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, quantity: 10, unit_price: 10.00)

    @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: "success")
    @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: "success")
    @transaction3 = create(:transaction, invoice_id: @invoice3.id, result: "success")
    @transaction4 = create(:transaction, invoice_id: @invoice4.id, result: "failed")
  end
#
#   {
#   "data": {
#     "id": "42",
#     "type": "merchant_revenue",
#     "attributes": {
#       "revenue"  : 532613.9800000001
#     }
#   }
# }

  describe 'Show Action' do
    it 'should return the total revenue for a single merchant' do
      # GET /api/v1/revenue/merchants/:id
      get "/api/v1/revenue/merchants/#{@merchant.id}"
      expect(response).to be_successful
      merchant = JSON.parse(response.body, symbolize_names: true)
      # binding.pry
      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id].to_i).to eq(@merchant.id)

      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data][:type]).to eq('merchant_revenue')

      # expect(merchant[:data][:attributes]).to have_key(:name)
      # expect(merchant[:data][:attributes][:name]).to be_a(String)
      # expect(merchant[:data][:attributes][:name]).to eq("Prosacco, Willms and Oberbrunner")

      expect(merchant[:data][:attributes]).to have_key(:revenue)
      expect(merchant[:data][:attributes][:revenue]).to be_a(Float)
      expect(merchant[:data][:attributes][:revenue]).to eq(900.0)
    end
  end

  describe 'sad path' do
    it 'bad integer id returns 404' do
      get "/api/v1/revenue/merchants/1111111111111"

      expect(response).not_to be_successful
      expect(response.status).to eq 404
    end
  end
end
