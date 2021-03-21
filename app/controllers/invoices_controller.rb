class InvoicesController < ApplicationController
  def donate_now
    @donation = Invoice.get_donation(current_parent) || InvoiceLineItem.new
    @checked = get_donation_radio_check(@donation.quantity)
    @program_donation = Invoice.get_program_donation(current_parent) || InvoiceLineItem.new
    @program_donation_checked = get_program_donation_radio_check(@program_donation.quantity)
  end

  def generate_initial_invoice
    @invoice = Invoice.find_by(parent_id: current_parent.id) || Invoice.create(parent: current_parent)
    unless @invoice.closed?
      @invoice.generate_initial_invoice
      current_parent.send_confirmation(@invoice)
      @invoice.update_attributes(closed: true)
    end
  end

  def update_donation_amount
    p = params[:invoice_line_item]
    p[:quantity] = p[:other_quantity] if p[:quantity] == "Other"
    p.delete("other_quantity")
    p[:product_id] = Product.where(name: "Scholarship Donation").first.id
    p[:parent_id] = current_parent.id

    if params[:invoice_line_item_id].nil?
      invoice = Invoice.find_by(parent_id: current_parent.id) || Invoice.create(parent: current_parent)
      @invoice_line_item = InvoiceLineItem.new(invoice: invoice)
      @invoice_line_item.update_attributes( invoice_line_item_params )
    else
      @invoice_line_item = InvoiceLineItem.find(params[:invoice_line_item_id])
      @invoice_line_item.update_attributes(invoice_line_item_params)
    end

    positive_message = "Your donation amount of $#{@invoice_line_item.quantity} was successfully saved. Thank you!"
    negative_message = @invoice_line_item.errors.full_messages

    @response_message = @invoice_line_item.valid? ? positive_message : negative_message
  end

  def update_program_donation
    p = params[:invoice_line_item]
    p[:quantity] = p[:other_quantity] if p[:quantity] == "Other"
    p.delete("other_quantity")
    p[:product_id] = Product.find_by(name: "Program Donation").id
    p[:parent_id] = current_parent.id

    if params[:invoice_line_item_id].nil?
      @invoice_line_item = InvoiceLineItem.create( invoice_line_item_params )
    else
      @invoice_line_item = InvoiceLineItem.find(params[:invoice_line_item_id])
      @invoice_line_item.update_attributes(invoice_line_item_params)
    end

    positive_message = "Your program donation of $#{@invoice_line_item.quantity} was successfully saved. Thank you!"
    negative_message = @invoice_line_item.errors.full_messages

    @response_message = @invoice_line_item.valid? ? positive_message : negative_message
  end

  private

  def invoice_line_item_params
    params.require(:invoice_line_item).permit(:quantity, :product_id, :parent_id)
  end

  def get_donation_radio_check(amount)
    [0,10,25,50].include?(amount) || amount.nil? ? amount.to_s : "Other"
  end

  def get_program_donation_radio_check(amount)
    [0,75,100,150].include?(amount) || amount.nil? ? amount.to_s : "Other"
  end
end
