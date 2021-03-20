require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'associations' do
    it { should have_many(:registrations) }
    it { should have_many(:students).through(:registrations) }
    it { should have_many(:wait_listed_students) }
  end

  describe 'instance method' do
    describe '#waitlist' do
      let(:parent) { create(:parent) }
      let(:section) { create(:section, course: FactoryBot.create(:course)) }
      let(:student_1) { create(:student, parent: parent) }
      let(:student_2) { create(:student, first_name: "Bob", parent: parent) }
      let(:student_3) { create(:student, first_name: "Rachel", parent: parent)}

      context 'when no student has been added' do
        it 'returns an empty array' do
          expect(section.waitlist).to eq([])
        end
      end

      context 'when one student has been added' do
        before do
          WaitListedStudent.create(student: student_1, section: section)
        end

        it 'returns an array with that one student' do
          expect(section.waitlist).to eq([student_1])
        end

        context 'and then a second student is added' do
          before do
            WaitListedStudent.create(student: student_2, section: section)
          end
          it 'returns an array with both students' do
            expect(section.waitlist).to eq([student_1, student_2])
          end

          it 'resulting array should be in order they were added to waitlist' do
            Timecop.travel(2.days.ago)
            WaitListedStudent.create(section: section, student: student_3)
            Timecop.return

            expect(section.waitlist).to eq([student_3, student_1, student_2])
          end
        end
      end
    end

    describe '#at_max?' do
      let(:section) { create(:section, class_maximum: 3) }

      context 'class is not at max enrollees' do
        it 'returns false' do
          allow(section.students).to receive(:count).and_return(1)

          expect(section.at_max?).to eq(false)
        end
      end

      context 'class is exactly max enrollees' do
        it 'returns true' do
          allow(section.students).to receive(:count).and_return(3)

          expect(section.at_max?).to eq(true)
        end
      end

      context 'class is above max enrollees' do
        it 'returns true' do
          allow(section.students).to receive(:count).and_return(5)

          expect(section.at_max?).to eq(true)
        end
      end
    end
  end
end
