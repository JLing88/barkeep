class CocktailSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :recipe
end