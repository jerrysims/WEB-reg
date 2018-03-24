require 'rails_helper'

RSpec.describe InvoiceLineItem, type: :model do
  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:parent) }
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:parent) }
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end
end
