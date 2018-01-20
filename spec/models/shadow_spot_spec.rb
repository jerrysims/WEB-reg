require 'rails_helper'

RSpec.describe ShadowSpot, type: :model do
  describe 'associations' do
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:date)}
  end
end
