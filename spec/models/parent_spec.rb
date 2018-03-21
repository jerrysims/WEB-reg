require 'rails_helper'

RSpec.describe Parent, type: :model do
  describe 'associations' do
    it { should have_many(:students) }
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
    describe '#full_name' do
      let (:parent) { create(:parent, first_name: "Eddie", last_name: "Rabbit") }

      it 'should return readable combination of first and last names' do
        expect(parent.full_name).to eql('Eddie Rabbit')
      end
    end
  end
end
