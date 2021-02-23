class Cocktail < ApplicationRecord
  belongs_to :search
  validates :recipe, presence: true
  validates :search_id, presence: :true
end
