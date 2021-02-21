require 'rails_helper'

RSpec.describe "Api::V1::Searches", type: :request do
  describe '#index' do
    it 'returns all searches' do
      search_1 = create(:search)
      search_2 = Search.create!(query: 'mojito', url: 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=mojito')

      get '/api/v1/searches'
      results = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(results).to have_key("data")
      expect(results["data"].count).to eq(2)
      expect(results["data"][0]["attributes"]["id"]).to eq(search_2.id)
      expect(results["data"][0]["attributes"]["query"]).to eq(search_2.query)
      expect(results["data"][0]["attributes"]["url"]).to eq(search_2.url)
      expect(results["data"][1]["attributes"]["id"]).to eq(search_1.id)
      expect(results["data"][1]["attributes"]["query"]).to eq(search_1.query)
      expect(results["data"][1]["attributes"]["url"]).to eq(search_1.url)
    end
  end
end
