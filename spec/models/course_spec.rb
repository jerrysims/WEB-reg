require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should have_many(:course_corequisites) }
    it { should have_many(:corequisites).through(:course_corequisites) }
    it { should have_many(:registrations) }
    it { should have_many(:students).through(:registrations) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:grades)}
    it { should validate_presence_of(:start_time)}
    it { should validate_presence_of(:start_time)}
    it { should validate_presence_of(:day)}
  end
end
