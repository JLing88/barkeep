require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'validations' do
    it { should validate_presence_of :query }
    # it { should validate_uniqueness_of :query }
    it { should validate_presence_of :url }
    it { should validate_presence_of :results }
  end

  it 'downcases query before saving' do
    search_1 = Search.create!(query: 'MarGaRitA', url: 'http://www.x.com', results: { stuff: 'Really cool stuff!' }.to_json )

    expect(search_1.query).to eq('margarita')
  end
end
