require 'rails_helper'

RSpec.describe ShadowSpot, type: :model do
  describe 'associations' do
    it { should have_many(:student_shadows) }
    it { should have_many(:students).through(:student_shadows) }
  end

  describe 'validations' do
    it { should validate_presence_of(:slot) }
    it { should validate_presence_of(:grade) }
    it { should validate_uniqueness_of(:date)}
  end
end
