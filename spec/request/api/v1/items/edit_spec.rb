require 'rails_helper'
RSpec.describe 'Item API' do
  before :each do
    @item = create(:item)
  end

  describe 'Edit/Update Item' do
    xit "can update an existing item" do
      previous_item = Item.last.name
      item_params = { name: "New Item" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch api_v1_item(@item.id), headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: @item.id)

      expect(response).to be_successful
      expect(item.name).not_to eq(previous_item)
      expect(item.name).to eq("New Item")
    end
  end

  describe 'sad path' do
    xit 'bad integer id returns 404' do
      item_params = { name: "New Item" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch api_v1_item(1234554321), headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: 1234554321)

      expect(response.status).to eq 404
    end

    xit 'bad merchant id returns 404' do
      previous_item = Item.last.name
      item_params = { merchant_id: 0 }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{@item.id}", headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: @item.id)

      expect(response.status).to eq(404)
    end
  end
end
