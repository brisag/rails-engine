require 'rails_helper'
RSpec.describe 'Items API', type: :request do
  before :each do
    @item = create(:item)

  end

  describe 'Item Destroy' do
    it "can delete an item" do
      delete "/api/v1/items/#{@item.id}"

			expect(response).to be_successful
			expect(response.status).to eq(204)
			expect(response.body).to be_empty
			expect{Item.find(@item.id)}.to raise_error(ActiveRecord::RecordNotFound)
		end
  end
end
