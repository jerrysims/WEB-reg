require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should have_many(:course_corequisites) }
    it { should have_many(:corequisites).through(:course_corequisites) }
    it { should have_many(:sections).dependent(:destroy) }
    it { should have_many(:registrations).through(:sections) }
    it { should have_many(:students).through(:registrations) }
    it { should belong_to(:registration_period) }
    it { should have_and_belong_to_many(:products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:grades) }
    it { should validate_inclusion_of(:division).in_array(Course::DIVISIONS) }
    it { should validate_uniqueness_of(:name).scoped_to(:registration_period_id) }
  end

  describe 'scopes' do
    let!(:academic_registration_period) { create(:registration_period, name: '2025-26 Academic Year', rp_type: 'academic') }
    let!(:extracurricular_registration_period) { create(:registration_period, name: '2025-26 Extracurricular Year', rp_type: 'extracurricular') }
    let!(:academic_course) { create(:course, registration_period: academic_registration_period) }
    let!(:extracurricular_course) { create(:course, registration_period: extracurricular_registration_period) }

    it 'returns academic courses' do
      expect(Course.academic).to include(academic_course)
      expect(Course.academic).not_to include(extracurricular_course)
    end

    it 'returns extracurricular courses' do
      expect(Course.extracurricular).to include(extracurricular_course)
      expect(Course.extracurricular).not_to include(academic_course)
    end
  end

  describe 'instance methods' do
    let!(:registration_period) { create(:registration_period) }
    let!(:course) { create(:course, registration_period: registration_period) }

    describe '#fee' do
      context 'when course has no product associated with it' do
        it 'returns zero' do
          expect(course.fee).to eq(0)
        end
      end

      context 'when course has a product associated with it' do
        let!(:product) { create(:product, product_type: 'fee', unit_price: 50, registration_period: registration_period) }

        it 'returns the unit_price of that product' do
          course.products << product
          expect(course.fee).to eq(50)
        end
      end
    end

    describe '#fee_product' do
      context 'when course has no fee product associated with it' do
        it 'returns nil' do
          expect(course.fee_product).to be_nil
        end
      end

      context 'when course has a fee product associated with it' do
        let!(:product) { create(:product, product_type: 'fee', registration_period: registration_period) }

        it 'returns the fee product' do
          course.products << product
          expect(course.fee_product).to eq(product)
        end
      end
    end

    describe '#semester_tuition' do
      # Add tests for semester_tuition method based on different conditions
    end
  end
end
