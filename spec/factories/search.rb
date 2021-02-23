FactoryBot.define do
  factory :search do
    query { 'margarita' }
    url  { 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita' }
    results { { stuff: 'Really cool stuff!' }.to_json }
  end
end