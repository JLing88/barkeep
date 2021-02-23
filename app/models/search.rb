class Search < ApplicationRecord
  before_save { query.downcase! }

  validates :query, presence: true, uniqueness: true
  validates :url, presence: true
  validates :results, presence: true
end
