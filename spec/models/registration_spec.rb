require 'rails_helper'

RSpec.describe Registration, type: :model do
  describe 'associations' do
    it { should belong_to(:section) }
    it { should belong_to(:student) }
  end

  describe 'validations' do
    it { should validate_presence_of(:section)}
    it { should validate_presence_of(:student)}
  end
end
