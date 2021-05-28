require 'rails_helper'
RSpec.describe 'Item API', type: :request do
  before :each do
    @item = create(:item)
  end

  describe 'Edit/Update Item' do
    xit "can update an existing item" do
      previous_item = Item.last.name
      item_params = { unit_price: 20.22 }
      headers = {"CONTENT_TYPE" => "application/json"}
      item = Item.find_by(id: @item)
      # binding.pry
      patch "/api/v1/items/#{@item.id}", headers: headers, params: JSON.generate({item: item_params})

      expect(response).to be_successful
      # expect(item.name).not_to eq(previous_item)
      expect(item.name).to eq(20.22)
    end
  end

  describe 'sad path' do
    it 'bad integer id returns 404' do
      item_params = { name: "New Item" }
      headers = {"CONTENT_TYPE" => "application/json"}
      item = Item.find_by(id: 1234554321)

      patch "/api/v1/items/1234554321", headers: headers, params: JSON.generate({item: item_params})

      expect(response.status).to eq 404
    end

    it 'bad merchant id returns 404' do
      previous_item = Item.last.name
      item_params = { merchant_id: 0 }
      headers = {"CONTENT_TYPE" => "application/json"}
      item = Item.find_by(id: @item.id)

      patch "/api/v1/items/#{@item.id}", headers: headers, params: JSON.generate({item: item_params})

      expect(response.status).to eq(404)
    end
  end
end
