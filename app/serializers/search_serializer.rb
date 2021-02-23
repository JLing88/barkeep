class SearchSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :query, :url, :results
end
