require 'rails_helper'

RSpec.describe "Api::V1::Searches", type: :request do
  describe 'GET #index' do
    before(:each) do
      @search_1 = create(:search)
      @search_2 = create(:search, query: "mojito")
      @search_3 = create(:search, query: "old fashioned")
    end

    it 'returns all searches sorted by descending order of updated_at by default' do
      expect(Search.count).to eq(3)

      get '/api/v1/searches'
      results = JSON.parse(response.body)
      data = results['data']

      expect(response.status).to eq(200)
      expect(results).to have_key('data')
      expect(data.count).to eq(3)
      expect(data[0]['attributes']['id']).to eq(@search_3.id)
      expect(data[0]['attributes']['query']).to eq(@search_3.query)
      expect(data[0]['attributes']['url']).to eq(@search_3.url)
      expect(data[0]['attributes']['results']).to eq(@search_3.results)
      expect(data[1]['attributes']['id']).to eq(@search_2.id)
      expect(data[1]['attributes']['query']).to eq(@search_2.query)
      expect(data[1]['attributes']['url']).to eq(@search_2.url)
      expect(data[1]['attributes']['results']).to eq(@search_2.results)
      expect(data[2]['attributes']['id']).to eq(@search_1.id)
      expect(data[2]['attributes']['query']).to eq(@search_1.query)
      expect(data[2]['attributes']['url']).to eq(@search_1.url)
      expect(data[2]['attributes']['results']).to eq(@search_1.results)
    end

    it 'can order all searches in ascending order if requested' do
      expect(Search.count).to eq(3)

      get '/api/v1/searches?order=asc'
      results = JSON.parse(response.body)
      data = results['data']

      expect(results).to have_key('data')
      expect(data.count).to eq(3)
      expect(data[0]['attributes']['id']).to eq(@search_1.id)
      expect(data[0]['attributes']['query']).to eq(@search_1.query)
      expect(data[0]['attributes']['url']).to eq(@search_1.url)
      expect(data[0]['attributes']['results']).to eq(@search_1.results)
      expect(data[1]['attributes']['id']).to eq(@search_2.id)
      expect(data[1]['attributes']['query']).to eq(@search_2.query)
      expect(data[1]['attributes']['url']).to eq(@search_2.url)
      expect(data[1]['attributes']['results']).to eq(@search_2.results)
      expect(data[2]['attributes']['id']).to eq(@search_3.id)
      expect(data[2]['attributes']['query']).to eq(@search_3.query)
      expect(data[2]['attributes']['url']).to eq(@search_3.url)
      expect(data[2]['attributes']['results']).to eq(@search_3.results)
    end
  end

  describe 'GET #show' do
    before(:each) do
      @search_1 = create(:search)
      @search_2 = create(:search, query: 'mojito')
    end

    it 'returns the Search object by id if found' do
      expect(Search.count).to eq(2)

      get "/api/v1/searches/#{@search_1.id}"
      results = JSON.parse(response.body)
      data = results['data']

      expect(response.status).to eq(200)
      expect(results).to have_key('data')
      expect(data['attributes']['id']).to eq(@search_1.id)
      expect(data['attributes']['query']).to eq(@search_1.query)
      expect(data['attributes']['url']).to eq(@search_1.url)
      expect(data['attributes']['results']).to eq(@search_1.results)

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

  describe 'DELETE #destroy' do
    before(:each) do
      @search_1 = create(:search)
      @search_2 = create(:search, query: 'mojito')
    end

    it 'deletes search object associated with :id param' do
      expect(Search.count).to eq(2)
      expect { delete "/api/v1/searches/#{@search_2.id}" }.to change{ Search.count }.by(-1)
      expect { delete "/api/v1/searches/#{@search_1.id}" }.to change{ Search.count }.by(-1)
      expect(response.body).to eq('Search has been deleted')
      expect(response.status).to eq(200)
    end

    it 'returns 404 not found if :id does not exist' do
      expect(Search.count).to eq(2)
      expect { delete '/api/v1/searches/111' }.to_not change{ Search.count }

      result = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(result["error"]).to eq("Couldn't find Search with 'id'=111")
    end
  end

  describe 'POST #create' do
    it 'can create a new Search object' do
      body = { cocktail: { query: 'margarita' } }

      expect(Search.count).to eq(0)
      expect { post '/api/v1/searches', params: body }.to change { Search.count }.by(1)

      result = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(result).to have_key('id')
      expect(result['query']).to eq(body[:cocktail][:query])
      expect(result).to have_key('url')
      expect(result).to have_key('results')
    end

    it 'returns 422 if invalid params are provided' do
      invalid_body = { not_a_cocktail: { query: 'something' } }

      expect(Search.count).to eq(0)
      expect { post '/api/v1/searches', params: invalid_body }.to_not change { Search.count }

      result = JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(result['error']).to eq("Missing parameter cocktail")
    end
  end
end
