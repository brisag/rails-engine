require 'rails_helper'
RSpec.describe 'Items API', type: :request do
  before :each do
    @merchant = create(:merchant)
    @id = create(:item, merchant: @merchant).id

  end

  describe 'Items ID' do
    it "can get one merchant by its id" do
      get "/api/v1/items/#{@id}"

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful

      attributes = item[:attributes]
      expect(attributes).to have_key(:merchant_id)
      expect(attributes[:merchant_id]).to be_a(Integer)
      expect(attributes[:merchant_id]).to eq(@merchant.id)
    end
  end
end
