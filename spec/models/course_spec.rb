require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should have_many(:course_corequisites) }
    it { should have_many(:corequisites).through(:course_corequisites) }
    it { should have_and_belong_to_many(:products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:grades)}
  end

  describe 'instance method' do
    describe '#fee' do
      let!(:course) { create(:course) }

      context 'when course has no product associated with it' do
        it 'returns zero' do
          expect(course.fee).to eq(0)
        end
      end

      context 'when course has a product associated with it' do
        let!(:product) { create(:product) }

        it 'returns the unit_price of that product' do
          course.products <<  product

          expect(course.fee).to eq(50)
        end
      end
    end
  end
end
