class SearchSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :query, :url
  has_many :cocktails
end
