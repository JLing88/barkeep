require 'rails_helper'

RSpec.describe "Api::V1::Searches", type: :request do
  describe 'GET #index' do
    before(:each) do
      @margarita_search = create(:search)
      @mojito_search = create(:search, query: "mojito")
      @old_fashioned_search = create(:search, query: "old%20fashioned")

      @classic_marg = @margarita_search.cocktails.create(
        recipe: {
          'strDrink': 'Classic Margarita',
          'strIngredient1': 'tequila',
          'strIngredient2': 'sweet and sour mix',
          'strIngredient3': 'contreau'
        }
      )

      @mango_lime_marg = @margarita_search.cocktails.create(
        recipe: {
          'strDrink': 'Mango Lime Margarita',
          'strIngredient1': 'tequila',
          'strIngredient2': 'sweet and sour mix',
          'strIngredient3': 'contreau',
          'strIngredient4': 'mango puree'
        }
      )

      @classic_mojito = @mojito_search.cocktails.create(
        recipe: {
          'strDrink': 'Classic Old Fashioned',
          'strIngredient1': 'rum',
          'strIngredient2': 'mint',
          'strIngredient3': 'lime',
          'strIngredient4': 'soda water'
        }
      )

      @classic_old_fashioned = @old_fashioned_search.cocktails.create(
        recipe: {
          'strDrink': 'Classic Mojito',
          'strIngredient1': 'bourbon',
          'strIngredient2': 'angostura bitters',
          'strIngredient3': 'sugar cube',
          'strIngredient4': 'cocktail cherry'
        }
      )
    end

    it 'returns all searches sorted by descending order of :updated_at by default' do
      #very thorough spec to ensure api response looks like it should
      expect(Search.count).to eq(3)
      get '/api/v1/searches'
      results = JSON.parse(response.body)
      data = results['data']
      included = results['included']

      expect(response.status).to eq(200)
      expect(data.count).to eq(3)
      expect(data[0]['attributes']['id']).to eq(@old_fashioned_search.id)
      expect(data[0]['attributes']['query']).to eq(@old_fashioned_search.query)
      expect(data[0]['attributes']['url']).to eq(@old_fashioned_search.url)
      expect(data[0]['relationships']['cocktails']['data'][0]['id']).to eq(@classic_old_fashioned.id.to_s)

      expect(data[1]['attributes']['id']).to eq(@mojito_search.id)
      expect(data[1]['attributes']['query']).to eq(@mojito_search.query)
      expect(data[1]['attributes']['url']).to eq(@mojito_search.url)
      expect(data[1]['relationships']['cocktails']['data'][0]['id']).to eq(@classic_mojito.id.to_s)

      expect(data[2]['attributes']['id']).to eq(@margarita_search.id)
      expect(data[2]['attributes']['query']).to eq(@margarita_search.query)
      expect(data[2]['attributes']['url']).to eq(@margarita_search.url)
      expect(data[2]['relationships']['cocktails']['data'][0]['id']).to eq(@classic_marg.id.to_s)
      expect(data[2]['relationships']['cocktails']['data'][1]['id']).to eq(@mango_lime_marg.id.to_s)

      expect(included[0]['id']).to eq(@classic_old_fashioned.id.to_s)
      expect(included[0]['type']).to eq('cocktail')
      expect(included[0]['attributes']['recipe']).to eq(@classic_old_fashioned.recipe)
      expect(included[1]['id']).to eq(@classic_mojito.id.to_s)
      expect(included[1]['type']).to eq('cocktail')
      expect(included[1]['attributes']['recipe']).to eq(@classic_mojito.recipe)
      expect(included[2]['id']).to eq(@classic_marg.id.to_s)
      expect(included[2]['type']).to eq('cocktail')
      expect(included[2]['attributes']['recipe']).to eq(@classic_marg.recipe)
      expect(included[3]['id']).to eq(@mango_lime_marg.id.to_s)
      expect(included[3]['type']).to eq('cocktail')
      expect(included[3]['attributes']['recipe']).to eq(@mango_lime_marg.recipe)
    end

    it 'can order all searches in ascending order by :updated_at' do
      expect(Search.count).to eq(3)

      get '/api/v1/searches?order=asc'
      results = JSON.parse(response.body)
      data = results['data']

      expect(results).to have_key('data')
      expect(data.count).to eq(3)
      expect(data[0]['attributes']['id']).to eq(@margarita_search.id)
      expect(data[0]['attributes']['query']).to eq(@margarita_search.query)
      expect(data[0]['attributes']['url']).to eq(@margarita_search.url)
      expect(data[1]['attributes']['id']).to eq(@mojito_search.id)
      expect(data[1]['attributes']['query']).to eq(@mojito_search.query)
      expect(data[1]['attributes']['url']).to eq(@mojito_search.url)
      expect(data[2]['attributes']['id']).to eq(@old_fashioned_search.id)
      expect(data[2]['attributes']['query']).to eq(@old_fashioned_search.query)
      expect(data[2]['attributes']['url']).to eq(@old_fashioned_search.url)
    end

    it 'can order all searches in descending order' do
      expect(Search.count).to eq(3)

      get '/api/v1/searches?order=desc'
      results = JSON.parse(response.body)
      data = results['data']

      expect(response.status).to eq(200)
      expect(results).to have_key('data')
      expect(data.count).to eq(3)
      expect(data[0]['attributes']['id']).to eq(@old_fashioned_search.id)
      expect(data[0]['attributes']['query']).to eq(@old_fashioned_search.query)
      expect(data[0]['attributes']['url']).to eq(@old_fashioned_search.url)
      expect(data[1]['attributes']['id']).to eq(@mojito_search.id)
      expect(data[1]['attributes']['query']).to eq(@mojito_search.query)
      expect(data[1]['attributes']['url']).to eq(@mojito_search.url)
      expect(data[2]['attributes']['id']).to eq(@margarita_search.id)
      expect(data[2]['attributes']['query']).to eq(@margarita_search.query)
      expect(data[2]['attributes']['url']).to eq(@margarita_search.url)
    end

    it 'can order by :query in descending order' do
      expect(Search.count).to eq(3)

      get '/api/v1/searches?order=alpha-desc'
      results = JSON.parse(response.body)
      data = results['data']

      expect(results).to have_key('data')
      expect(data.count).to eq(3)
      expect(data[0]['attributes']['id']).to eq(@old_fashioned_search.id)
      expect(data[0]['attributes']['query']).to eq(@old_fashioned_search.query)
      expect(data[0]['attributes']['url']).to eq(@old_fashioned_search.url)
      expect(data[1]['attributes']['id']).to eq(@mojito_search.id)
      expect(data[1]['attributes']['query']).to eq(@mojito_search.query)
      expect(data[1]['attributes']['url']).to eq(@mojito_search.url)
      expect(data[2]['attributes']['id']).to eq(@margarita_search.id)
      expect(data[2]['attributes']['query']).to eq(@margarita_search.query)
      expect(data[2]['attributes']['url']).to eq(@margarita_search.url)
    end

  it 'can order by query in descending order' do
    expect(Search.count).to eq(3)

    get '/api/v1/searches?order=asc'
    results = JSON.parse(response.body)
    data = results['data']

    expect(results).to have_key('data')
    expect(data.count).to eq(3)
    expect(data[0]['attributes']['id']).to eq(@margarita_search.id)
    expect(data[0]['attributes']['query']).to eq(@margarita_search.query)
    expect(data[0]['attributes']['url']).to eq(@margarita_search.url)
    expect(data[1]['attributes']['id']).to eq(@mojito_search.id)
    expect(data[1]['attributes']['query']).to eq(@mojito_search.query)
    expect(data[1]['attributes']['url']).to eq(@mojito_search.url)
    expect(data[2]['attributes']['id']).to eq(@old_fashioned_search.id)
    expect(data[2]['attributes']['query']).to eq(@old_fashioned_search.query)
    expect(data[2]['attributes']['url']).to eq(@old_fashioned_search.url)
  end

  it 'can filter :query by string match' do
    expect(Search.count).to eq(3)

    get '/api/v1/searches?filter=ma'
    results = JSON.parse(response.body)
    data = results['data']

    expect(results).to have_key('data')
    expect(data.count).to eq(1)
    expect(data[0]['attributes']['query']).to eq(@margarita_search.query)
    expect(data[0]['attributes']['url']).to eq(@margarita_search.url)
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

    it 'can handle multiple word queries' do
      body = { cocktail: { query: 'old%20fashioned' } }

      expect(Search.count).to eq(0)
      expect { post '/api/v1/searches', params: body }.to change { Search.count }.by(1)

      result = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(result).to have_key('id')
      expect(result['query']).to eq('old fashioned')
      expect(result).to have_key('url')
      expect(result).to have_key('results')
    end
  end
end
