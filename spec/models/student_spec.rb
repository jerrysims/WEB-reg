require 'spec_helper'

RSpec.describe Student, type: :model do
  describe 'associations' do
    it { should have_many(:student_shadows) }
    it { should have_many(:shadow_spots).through(:student_shadows) }
  end
end
