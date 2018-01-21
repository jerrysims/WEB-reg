require 'rails_helper'

RSpec.describe ShadowSpot, type: :model do
  describe 'associations' do
    it { should have_one(:student_shadow) }
    it { should have_one(:student).through(:student_shadow) }
    it { should belong_to(:subject) }
    it { should have_one(:teacher).through(:subject) }
  end

  describe 'validations' do
    it { should validate_presence_of(:time) }
    it { should validate_uniqueness_of(:date)}
    it { should validate_uniqueness_of(:date).scoped_to([:subject_id, :time]) }
  end

  describe 'scopes' do
    describe 'unscheduled' do
      let!(:subject1) { create(:subject, name: 'subject1') }
      let!(:subject2) { create(:subject, name: 'subject2') }
      let!(:scheduled) { create(:shadow_spot, date: 2.weeks.from_now, subject: subject1) }
      let!(:unscheduled) { create(:shadow_spot, date: 3.weeks.from_now, subject: subject2) }
      let!(:student_shadow) { create(:student_shadow, shadow_spot: scheduled)}

      it 'only returns the unscheduled shadow_spots' do
        expect(ShadowSpot.unscheduled).to match_array([unscheduled])
      end
    end
  end

  describe 'instance method' do
    let! (:subject) { create(:subject, name: "Biology", grade: 5) }
    let! (:shadow_spot) { create(:shadow_spot, date: "2018-11-06", subject: subject) }

    describe 'name_for_select' do
      it 'should return legible string of the time of the class' do
        expect(shadow_spot.name_for_select).to eql('Biology: 11/6/2018, 8:45 AM')
      end
    end

    describe 'subject_grade' do
      it 'returns the grade of the subject' do
        expect(shadow_spot.subject_grade).to eql(shadow_spot.subject.grade)
      end
    end
  end
end
