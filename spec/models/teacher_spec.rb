require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe 'associations' do
    it { should belong_to(:subject) }
    it { should have_many(:shadow_spots).through(:subject) }
  end
end
