RSpec.describe "Api::V1::Searches", type: :request do

  describe 'POST #create' do
    it 'can create a new Search object and associated Cocktails' do
      body = { cocktail: { query: 'margarita' } }

      expect(Search.count).to eq(0)
      expect { post '/api/v1/searches', params: body }.to change { Search.count }.by(1)
      search = Search.last

      result = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(result['data']['id']).to eq(search.id.to_s)
      expect(result['data']['type']).to eq('search')
      expect(result['data']['attributes']['query']).to eq(body[:cocktail][:query])
      expect(result['data']).to have_key('relationships')
    end

    it 'returns 422 if invalid params are provided' do
      invalid_body = { not_a_cocktail: { query: 'something' } }

      expect(Search.count).to eq(0)
      expect { post '/api/v1/searches', params: invalid_body }.to_not change { Search.count }

      result = JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(result['error']).to eq("Missing parameter cocktail")
    end

    it 'can handle multiple word queries' do
      body = { cocktail: { query: 'old%20fashioned' } }

      expect(Search.count).to eq(0)
      expect { post '/api/v1/searches', params: body }.to change { Search.count }.by(1)

      search = Search.last

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result['data']['id']).to eq(search.id.to_s)
      expect(result['data']['attributes']['query']).to eq('old fashioned')
      expect(result['data']['attributes']).to have_key('url')
      expect(result['data']).to have_key('relationships')
    end
  end
end