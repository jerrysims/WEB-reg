require 'rails_helper'

RSpec.describe CourseCorequisite, type: :model do
  describe 'associations' do
    it { should belong_to(:course) }
    it { should belong_to(:corequisite) }
  end
end
