require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'associations' do
    it { should belong_to(:parent) }
    it { should have_many(:invoice_line_items) }
  end

  describe 'validations' do
  end

  describe 'instance_methods' do
    let(:parent) { create(:parent) }
    let(:invoice) { create(:invoice, parent: parent) }
    let(:product) { create(:product) }
    let(:product_2) { create(:product, name: "Another Product") }

    describe '#total_due' do
      context 'when there are no line items in the invoice' do
        it 'should return 0' do
          expect(invoice.total_due).to eq(0)
        end
      end

      context 'when there is one line item' do
        let!(:invoice_line_item) { create(:invoice_line_item, product: product, invoice: invoice, parent: parent) }

        it 'should return the value of that line item' do
          expect(invoice.total_due).to eq(50)
        end
      end

      context 'when there is more than one line item' do
        let!(:invoice_line_item) { create(:invoice_line_item, product: product, invoice: invoice, parent: parent) }
        let!(:invoice_line_item_2) { create(:invoice_line_item, product: product_2, invoice: invoice, parent: parent) }

        it 'should return the sum of those two line items' do
          expect(invoice.total_due).to eq(100)
        end
      end
    end
  end
end
