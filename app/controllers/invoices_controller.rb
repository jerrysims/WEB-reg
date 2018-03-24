class InvoicesController < ApplicationController
  DONATION_PRODUCT = Product.where(name: "Scholarship Donation").first

  def update_donation_amount
    p = params[:invoice_line_item]
    p[:quantity] = p[:other_quantity] if p[:quantity] == "Other"
    p.delete("other_quantity")
    p[:product_id] = DONATION_PRODUCT.id
    p[:parent_id] = current_parent.id

    if params[:invoice_line_item_id].nil?
      @invoice_line_item = InvoiceLineItem.create( invoice_line_item_params )
    else
      @invoice_line_item = InvoiceLineItem.find(params[:invoice_line_item_id])
      @invoice_line_item.update_attributes(invoice_line_item_params)
    end

    positive_message = "Your donation amount of $#{@invoice_line_item.quantity} was successfully saved. Thank you!"
    negative_message = @invoice_line_item.errors.full_messages

    @response_message = @invoice_line_item.valid? ? positive_message : negative_message
  end

  private

  def invoice_line_item_params
    params.require(:invoice_line_item).permit(:quantity, :product_id, :parent_id)
  end
end
