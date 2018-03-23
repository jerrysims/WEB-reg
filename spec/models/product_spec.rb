require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:courses) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:unit_price)}
    it { should validate_inclusion_of(:product_type).in_array(%w(registration tuition fee study))}
  end

end
