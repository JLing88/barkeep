class Search < ApplicationRecord
  validates :query, presence: true, uniqueness: true
  validates :url, presence: true
end
