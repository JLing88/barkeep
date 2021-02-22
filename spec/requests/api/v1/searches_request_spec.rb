require 'rails_helper'

RSpec.describe "Api::V1::Searches", type: :request do
  describe 'GET #index' do
    before(:each) do
      @search_1 = create(:search)
      @search_2 = Search.create!(query: 'mojito', url: 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito')
    end

    it 'returns all searches' do
      expect(Search.count).to eq(2)

      get '/api/v1/searches'
      results = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(results).to have_key('data')
      expect(results['data'].count).to eq(2)
      expect(results['data'][0]['attributes']['id']).to eq(@search_2.id)
      expect(results['data'][0]['attributes']['query']).to eq(@search_2.query)
      expect(results['data'][0]['attributes']['url']).to eq(@search_2.url)
      expect(results['data'][1]['attributes']['id']).to eq(@search_1.id)
      expect(results['data'][1]['attributes']['query']).to eq(@search_1.query)
      expect(results['data'][1]['attributes']['url']).to eq(@search_1.url)
    end
  end

  describe 'GET #show' do
    before(:each) do
      @search_1 = create(:search)
      @search_2 = Search.create!(query: 'mojito', url: 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito')
    end

    it 'returns the Search object by id if found' do
      expect(Search.count).to eq(2)

      get "/api/v1/searches/#{@search_1.id}"
      results = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(results).to have_key('data')
      expect(results['data']['attributes']['id']).to eq(@search_1.id)
      expect(results['data']['attributes']['query']).to eq(@search_1.query)
      expect(results['data']['attributes']['url']).to eq(@search_1.url)

      get "/api/v1/searches/#{@search_2.id}"
      results = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(results).to have_key('data')
      expect(results['data']['attributes']['id']).to eq(@search_2.id)
      expect(results['data']['attributes']['query']).to eq(@search_2.query)
      expect(results['data']['attributes']['url']).to eq(@search_2.url)
    end

    it 'returns 404 not found if :id does not exist' do
      get '/api/v1/searches/111'

      result = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(result["error"]).to eq("Couldn't find Search with 'id'=111")
    end
  end
end
