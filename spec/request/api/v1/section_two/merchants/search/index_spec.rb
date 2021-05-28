require 'rails_helper'
RSpec.describe 'Merchants::Search Mercahnt API', type: :request do
  before :each do
    # @merchant = create(:merchant, 10)
    @merchant2 = create(:merchant, name: 'My Mart')
    @merchant3 = create(:merchant, name: 'Walmart')
    @merchant4 = create(:merchant, name: 'King Soopers')
  end

  describe 'find_all: find all merchants which match a search term' do
    it 'show all merchants by fragment' do
      get '/api/v1/merchants/find_all?name=Mart'

      expect(response).to be_successful

      search_fragment = JSON.parse(response.body, symbolize_names: true)
      # binding.pry
      expect(search_fragment[:data].count).to eq(2)

      search_fragment[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id].to_i).to be_an(Integer)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to eq('merchant')

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end
  end

  describe 'sad path' do
    it 'no fragment matched' do
      get '/api/v1/merchants/find_all?name=lmnopqrstuv'

      expect(response).to be_successful

      search_fragment = JSON.parse(response.body, symbolize_names: true)

      expect(search_fragment[:data]).to be_an(Array)
    end

    it 'no fragment matched' do
      get '/api/v1/merchants/find_all?name=NOMATCH'

      expect(response).to be_successful

      search_fragment = JSON.parse(response.body, symbolize_names: true)

      expect(search_fragment[:data]).to be_an(Array)
    end
  end
end

# require 'rails_helper'
#
# RSpec.describe 'Find one Merchant API' do
#   before :each do
#     merchant = create_list(:merchant, 30)
#     merchant2 = create(:merchant, name: "little esty shop")
#   end
#
#   it 'Can find one merchant by name fragment' do
#     get "/api/v1/merchants/find?name=#{merchant.name}"
#
#     expected = JSON.parse(response.body, symbolize_names: true)
#
#     expect(response).to be_successful
#     expect(response.status).to eq 200
#     expect(expected[:data][:attributes][:name]).to eq(merchant.name)
#     expect(expected.length).to eq 1
#     expect(expected).to be_a Hash
#   end
#
#   it 'Find all Merchants by name fragment' do
#     get "/api/v1/merchants/find?name=esty"
#
#     expected = JSON.parse(response.body, symbolize_names: true)
#
#     expect(expected[:data][:attributes][:name]).to eq(merchant2.name)
#   end
#
#   it 'Returns error when match does not happen' do
#
#     get "/api/v1/merchants/find?name=NOMATCH"
#     expected = JSON.parse(response.body, symbolize_names: true)
#
#     expect(response.status).to eq 400
#     expect(expected).to have_key(:data)
#   end
#   it 'Should error when no param given' do
#
#     get "/api/v1/merchants/find"
#     expected = JSON.parse(response.body, symbolize_names: true)
#
#     expect(response.status).to eq 400
#     expect(expected).to have_key(:data)
#   end
# end
