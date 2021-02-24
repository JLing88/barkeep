RSpec.describe "Api::V1::Searches", type: :request do
  describe 'GET #show' do
    before(:each) do
      @margarita_search = create(:search)
      @mojito_search = create(:search, query: 'mojito')

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
    end

    it 'returns the Search object by id if found' do
      expect(Search.count).to eq(2)

      get "/api/v1/searches/#{@margarita_search.id}"
      results = JSON.parse(response.body)
      data = results['data']

      expect(response.status).to eq(200)
      expect(results).to have_key('data')
      expect(data['attributes']['id']).to eq(@margarita_search.id)
      expect(data['attributes']['query']).to eq(@margarita_search.query)
      expect(data['attributes']['url']).to eq(@margarita_search.url)
      expect(results['included'].length).to eq(2)
      expect(results['included'][0]['id']).to eq(@classic_marg.id.to_s)
      expect(results['included'][1]['id']).to eq(@mango_lime_marg.id.to_s)

      get "/api/v1/searches/#{@mojito_search.id}"
      results = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(results).to have_key('data')
      expect(results['data']['attributes']['id']).to eq(@mojito_search.id)
      expect(results['data']['attributes']['query']).to eq(@mojito_search.query)
      expect(results['data']['attributes']['url']).to eq(@mojito_search.url)
      expect(results['included'].length).to eq(1)
      expect(results['included'][0]['id']).to eq(@classic_mojito.id.to_s)

    end

    it 'returns 404 not found if :id does not exist' do
      get '/api/v1/searches/111'
      result = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(result["error"]).to eq("Couldn't find Search with 'id'=111")
    end
  end
end
