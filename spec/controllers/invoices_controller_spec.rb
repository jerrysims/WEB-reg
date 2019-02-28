require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  describe "instance methods" do
    describe "#generate_initial_invoice" do
      let(:parent) { create(:parent) }
      let(:invoice) { create(:invoice, parent: parent) }

      before do
        allow(parent).to receive(:send_confirmation).with(invoice)
      end

      it "should fire email to parent" do
        get :generate_initial_invoice, params: { parent_id: parent.id }
      end
    end
  end

end
