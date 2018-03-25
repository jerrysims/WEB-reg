require 'rails_helper'

RSpec.describe Parent, type: :model do
  describe 'associations' do
    it { should have_many(:students) }
    it { should have_many(:invoices) }
    it { should have_many(:invoice_line_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:street_address_1).on(:course_registration)}
    it { should validate_presence_of(:city).on(:course_registration)}
    it { should validate_presence_of(:state).on(:course_registration)}
    it { should validate_presence_of(:zip_code).on(:course_registration)}
  end

  describe 'instance method' do
    let!(:parent) { create(:parent, first_name: "Eddie", last_name: "Rabbit", tuition_preference: "monthly") }

    describe '#full_name' do
      it 'should return readable combination of first and last names' do
        expect(parent.full_name).to eql('Eddie Rabbit')
      end
    end

    describe '#registered_students' do
      let(:student) { create(:student, parent: parent) }

      context 'when no students are registered for a course' do
        it 'returns an empty association' do
          expect(parent.registered_students).to eq([])
        end
      end

      context 'when students are registered' do
        let(:course) { create(:course, grades: student.grade) }
        let!(:registration) { create(:registration, student: student, course: course) }

        it 'returns an array with those students' do
          expect(parent.registered_students).to eq([student])
        end
      end
    end

    describe '#send_confirmation' do
      let!(:invoice) { create(:invoice, parent: parent) }

      it 'should call the mailer' do
        allow_any_instance_of(ConfirmationMailer).to receive(:registration_confirmation_email).with(parent, invoice)

        parent.send_confirmation(invoice)
      end
    end
  end
end
