require 'spec_helper'

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
end
