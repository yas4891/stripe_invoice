require_dependency "stripe_invoice/application_controller"
require "prawn-rails"

module StripeInvoice
  class InvoicesController < ApplicationController
    
    before_filter :authorize_owner
    
    def index
      @subscription = @owner.subscription
      
      @invoices = Charge.where(owner_id: @owner.id).order('date DESC')
    end
    
    def show
      @invoice = Charge.find(params[:id])

      respond_to do |format|
        format.html {render layout: false}
        format.pdf
      end
    end
    
    def tax_report(data)
      @_response = ActionDispatch::Response.new
      @data = data
      render template: 'stripe_invoice/invoices/tax_report', :formats => [:pdf], :locals => {sicharges: data}
    end
    
    private
    def authorize_owner
      @owner = send("current_#{::Koudoku.subscriptions_owned_by}")
      redirect_to '/' unless @owner
    end

    def generate_invoice(scharge, owner, scharge_invoice, scharge_refund=nil, parent_invoice=nil)
      amount, stripe_refund_id, parent_invoice_id = scharge_invoice[:total], nil, nil
      if scharge_refund.present?
        amount = -scharge_refund.amount #'-' For refund
        stripe_refund_id = scharge_refund.id
        parent_invoice_id = parent_invoice.id if parent_invoice.present?
      end

      Charge.create({
        stripe_id: scharge_invoice.id,
        owner_id: owner.id, 
        date: scharge.created, 
        invoice_number: "ls-#{Date.today.year}-#{(Invoice.last ? (Invoice.last.id * 7) : 1).to_s.rjust(5, '0')}", 
        json: scharge_invoice,
        amount: amount,
        stripe_refund_id: stripe_refund_id,
        parent_invoice_id: parent_invoice_id
      })
    end

  end
end
