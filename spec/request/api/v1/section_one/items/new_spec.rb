require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  before :each do
    # @item = create(:item)
    @merchant = create(:merchant)

  end

  describe 'Items New Page' do
    it 'can create an item' do
      item_params =  {
                      "name": "value1",
                      "description": "value2",
                      "unit_price": 100.99,
                      "merchant_id": @merchant.id
                    }

      headers = {'CONTENT_TYPE' => 'application/json'}
      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      item_created = Item.last

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(item_created.name).to eq(item_params[:name])
      expect(item_created.description).to eq(item_params[:description])
      expect(item_created.unit_price).to eq(item_params[:unit_price])
      expect(item_created.merchant_id).to eq(@merchant.id)

    end
  end

  describe 'Sad path' do
    it 'return an error if any attribute is missing' do
      item_params = {
                      "name": "value1",
                      "unit_price": 100.99,
                      "merchant_id": @merchant.id
                    }

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

      expect(response).not_to be_successful
      expect(response.status).to eq(400)
    end

    it 'should ignore any attributes sent by the user which are not allowed' do
      item_params = {
                      "name": "value1",
                      "description": "value2",
                      "extra_param": "Hello",
                      "unit_price": 100.99,
                      "merchant_id": @merchant.id
                    }

      headers = {"CONTENT_TYPE" => "application/json"}

      post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)
      item_created = Item.last

      # expect(response).not_to be_successful
      expect(item_created).not_to have_attribute(:extra_param)
    end
  end
end
