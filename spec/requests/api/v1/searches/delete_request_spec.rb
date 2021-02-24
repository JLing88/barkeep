RSpec.describe "Api::V1::Searches", type: :request do
  describe 'DELETE #destroy' do
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

    it 'deletes search object associated with :id param' do
      expect(Search.count).to eq(2)
      expect(Cocktail.count).to eq(3)
      expect { delete "/api/v1/searches/#{@mojito_search.id}" }.to change{ Search.count }.by(-1)
      expect(response.status).to eq(200)
      expect(Cocktail.count).to eq(2)

      expect { delete "/api/v1/searches/#{@margarita_search.id}" }.to change{ Search.count }.by(-1)
      expect(response.body).to eq('Search has been deleted')
      expect(response.status).to eq(200)
      expect(Cocktail.count).to eq(0)
    end

    it 'returns 404 not found if :id does not exist' do
      expect(Search.count).to eq(2)
      expect { delete '/api/v1/searches/111' }.to_not change{ Search.count }

      result = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(result["error"]).to eq("Couldn't find Search with 'id'=111")
    end
  end
end
