require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'associations' do
    it { should belong_to(:parent) }
    it { should have_many(:invoice_line_items) }
  end

  describe 'validations' do
  end

end
