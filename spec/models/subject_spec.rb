require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe 'associations' do
    it { should have_one(:teacher) }
    it { should have_one(:shadow_spot) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:grade) }
    it { should validate_uniqueness_of(:grade).scoped_to(:name) }
  end
end
