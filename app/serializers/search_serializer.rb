class SearchSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :query, :url
end
