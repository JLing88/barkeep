require 'rails_helper'

RSpec.describe Cocktail, type: :model do
  describe 'validations' do
    it { should belong_to :search }
    it { should validate_presence_of :recipe }
  end
end
