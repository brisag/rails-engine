require 'rails_helper'
RSpec.describe 'Merchant Items API', type: :request do
  before :each do
    @merchant = create(:merchant)

    create_list(:item, 5, merchant: @merchant)
  end

  describe 'Merchant Item Index' do
    it 'get all items for a given merchant ID' do
      get "/api/v1/merchants/#{@merchant.id}/items"
      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id].to_i).to be_an(Integer)

        expect(item).to have_key(:type)
        expect(item[:type]).to eq('item')

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price].to_f).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end
  end
end
