require 'rails_helper'
RSpec.describe 'Items API', type: :request do
  before :each do
    @merchant = create(:merchant)

    create_list(:item, 5, merchant: @merchant)
  end

  describe 'Items ID' do
    it 'get the merchant data for a given item ID' do 
    end
  end
end
