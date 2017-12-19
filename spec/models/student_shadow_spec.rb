require 'rails_helper'

RSpec.describe StudentShadow, type: :model do
  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:shadow_spot) }
  end
end
