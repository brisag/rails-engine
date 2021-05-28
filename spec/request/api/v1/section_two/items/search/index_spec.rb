require 'rails_helper'
RSpec.describe 'Find one Item API', type: :request  do
  before :each do
    @item1 = create(:item, name: 'Name')
    @item2 = create(:item, name: 'Turing')
    @item3 = create(:item, name: 'Ring Mart')
    @item4 = create(:item, name: 'game')
    @item5 = create(:item, name: 'flame')
  end

  describe 'happy path' do
    it 'show one item by fragment' do
      get '/api/v1/items/find?name=ring'

      expect(response).to be_successful

      ring_search = JSON.parse(response.body, symbolize_names: true)
      # binding.pry

      expect(ring_search[:data]).to have_key(:id)
      expect(ring_search[:data][:id].to_i).to be_an(Integer)

      expect(ring_search[:data]).to have_key(:type)
      expect(ring_search[:data][:type]).to eq('item')

      expect(ring_search[:data][:attributes]).to have_key(:name)
      expect(ring_search[:data][:attributes][:name]).to be_a(String)
      expect(ring_search[:data][:attributes][:name]).to eq(@item3.name)

      expect(ring_search[:data][:attributes]).to have_key(:description)
      expect(ring_search[:data][:attributes][:description]).to be_a(String)
      expect(ring_search[:data][:attributes][:description]).to eq(@item3.description)

      expect(ring_search[:data][:attributes]).to have_key(:unit_price)
      expect(ring_search[:data][:attributes][:unit_price].to_f).to be_a(Float)
      expect(ring_search[:data][:attributes][:unit_price].to_f).to eq(@item3.unit_price.to_f)

      expect(ring_search[:data][:attributes]).to have_key(:merchant_id)
      expect(ring_search[:data][:attributes][:merchant_id]).to be_a(Integer)
      expect(ring_search[:data][:attributes][:merchant_id]).to eq(@item3.merchant_id)
    end
  end

  describe 'sad path' do
    it 'no fragment matched' do
      get '/api/v1/items/find?name=NOMATCH'

      expect(response).to be_successful

      ring_search = JSON.parse(response.body, symbolize_names: true)

      expect(ring_search[:data]).to eq({})
    end
  end
end
