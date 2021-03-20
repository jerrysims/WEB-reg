require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'associations' do
    it { should have_many(:student_shadows) }
    it { should have_many(:shadow_spots).through(:student_shadows) }
    it { should belong_to(:parent) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:date_of_birth) }
    it { should validate_presence_of(:grade) }
    it { should validate_presence_of(:emergency_contact) }
    it { should validate_presence_of(:emergency_phone) }
  end

  describe 'instance methods' do
    describe '#full_name' do
    end

    describe '#parents_full_name' do
    end

    describe '#eligible_courses' do
    end

    describe '#wait_listed_courses' do
      let(:course_1) { create(:course) }
      let(:course_2) { create(:course) }
      let(:section_1) { create(:section, course: course_1) }
      let(:section_2) { create(:section, course: course_2) }
      let(:student) { create(:student) }

      context 'when no course has been waitlisted' do
        it 'returns an empty array' do
          expect(student.wait_listed_courses).to eq([])
        end
      end

      context 'when one course has been waitlisted' do
        before do
          WaitListedStudent.create(student: student, section: section_1)
        end

        it 'returns an array with that one course' do
          expect(student.wait_listed_courses).to eq([course_1])
        end

        context 'and then a second course is waitlisted' do
          before do
            WaitListedStudent.create(student: student, section: section_2)
          end

          it 'returns an array with both courses' do
            expect(student.wait_listed_courses).to eq([course_1, course_2])
          end
        end
      end
    end
  end
end
