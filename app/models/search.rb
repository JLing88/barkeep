class Search < ApplicationRecord
  before_save { query.downcase! }
  before_save :decode_query

  validates :query, presence: true, uniqueness: true
  validates :url, presence: true
  validates :results, presence: true

  def decode_query
    query.gsub!('%20', ' ')
  end
end
