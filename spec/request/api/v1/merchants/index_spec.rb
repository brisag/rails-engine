require 'rails_helper'

RSpec.describe "Merchants API", type: :request do
  before :each do
    create_list(:merchant, 50)
  end

  describe 'Merchant Index' do
    it "get all merchants" do
      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(20)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id].to_i).to be_an(Integer)
        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to eq('merchant')
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'can get all merchants, a maximum of 20 at a time' do
      get '/api/v1/merchants'
      first_20 = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/merchants?page=1'
      expect(response).to be_successful

      page_1 = JSON.parse(response.body, symbolize_names: true)

      expect(first_20[:data].count).to eq(20)
      expect(first_20[:data]).to eq(page_1[:data])
    end

    it 'can get next page of 20 merchants' do
      get '/api/v1/merchants?page=1'
      page_1 = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/merchants?page=2'

      expect(response).to be_successful

      page_2 = JSON.parse(response.body, symbolize_names: true)

      expect(page_2[:data].count).to eq(20)

      page_1_first_id = page_1[:data].first[:id].to_i
      page_2_first_id = page_1_first_id + 20

      expect(page_2[:data].first[:id].to_i).to eq(page_2_first_id)
    end

    it 'can get page 3 of merchants' do
      get '/api/v1/merchants?page=1'
      page_1 = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/merchants?page=2'
      page_2 = JSON.parse(response.body, symbolize_names: true)

      get '/api/v1/merchants?page=3'
      page_3 = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful


      expect(page_3[:data].count).to eq(10)

      page_1_first_id = page_1[:data].first[:id].to_i
      page_2_first_id = page_1_first_id + 20
      page_3_first_id = page_2_first_id + 20
      # binding.pry
      expect(page_3[:data].first[:id].to_i).to eq(page_3_first_id)
    end

    it 'can get page 50 of merchants, shows 0 data' do
      get '/api/v1/merchants?page=50'
      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchants[:data].count).to eq(0)
    end

    it 'shows OPTIONAL query params. Shows page of 50 merchants' do
      get '/api/v1/merchants?per_page=50'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(50)
    end

    it 'shows OPTIONAL query params. Shows page of 500 merchants' do
      get '/api/v1/merchants?per_page=500'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(50)
    end
  end
end
