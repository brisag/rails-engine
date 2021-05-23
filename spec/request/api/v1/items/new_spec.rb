require 'rails_helper'
RSpec.describe 'Items API', type: :request do
  before :each do
    @merchant = create(:merchant)

    create_list(:item, 5, merchant: @merchant)
  end

  describe 'Items New Page' do
    it 'can create an item' do 
    end
  end
end
