require 'rails_helper'
RSpec.describe 'Merchant API', type: :request do
  before :each do
    @merchant = create(:merchant)
    @item = create(:item, merchant: @merchant)
  end

  describe 'Items ID' do
    it "can get the merchant data for a given item ID" do
      # api/v1/items/{{item_id}}/merchant
      get "/api/v1/items/#{@item.id}/merchant"
      merchant = JSON.parse(response.body, symbolize_names: true)
      # binding.pry

      expect(response).to be_successful

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id].to_i).to eq(@merchant.id)

      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end
  end

  describe 'sad path' do
    it 'returns 404 with bad id' do
      get "/api/v1/items/1111111111111/merchant"

      expect(response.status).to eq 404
    end

    it 'returns 404 with string id' do
      get "/api/v1/items/twelve/merchant"

      expect(response.status).to eq 404
    end
  end
end
