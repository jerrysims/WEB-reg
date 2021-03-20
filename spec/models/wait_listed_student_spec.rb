require 'rails_helper'

RSpec.describe WaitListedStudent, type: :model do
  describe 'associations' do
    it { should belong_to(:section) }
    it { should belong_to(:student) }
  end

  describe 'validations' do
    it { should validate_presence_of(:section_id)}
    it { should validate_presence_of(:student_id)}
  end
end
