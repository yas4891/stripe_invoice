require_dependency "stripe_invoice/application_controller"
require "prawn-rails"

module StripeInvoice
  class InvoicesController < ApplicationController
    
    def index
      @owner = send("current_#{::Koudoku.subscriptions_owned_by}")
      redirect_to '/' unless @owner

      @subscription = @owner.subscription
      if @subscription
        # I know this looks silly, but Koudoku actually stores the customer's stripe_id 
        # in the subscription model
        @stripe_charges = Stripe::Charge.all(
          :customer => @subscription.stripe_id,
          :limit => 100)

        @stripe_charges.each do |scharge|
          scharge_invoice = Stripe::Invoice.retrieve(scharge.invoice) rescue {}

          next if scharge_invoice.blank?
          invoice_count = Invoice.find_all_by_stripe_id(scharge_invoice.id).count
          scharge_count = scharge.refunds.count + 1
          next if scharge_count == invoice_count #Execute next if count is equal. But here we can miss the case if refund get updated.
          #Do we need to make one flag 'refund_deleted' to manage refund deleted or not ?

          generate_invoice(scharge, @owner, scharge_invoice) if invoice_count==0

          #Check for refund and create invoice
          if scharge.refunds.present?
            scharge.refunds.each do |scharge_refund|
              next if Invoice.find_by_stripe_refund_id(scharge_refund.id).present?
              generate_invoice(scharge, @owner, scharge_invoice, scharge_refund)              
            end
          end # if scharge.refunds
        end
      end # if subscription
      
      @invoices = Invoice.where(owner_id: @owner.id).order('stripe_id, date DESC')
    end
    
    def show
      @owner = send("current_#{::Koudoku.subscriptions_owned_by}")
      redirect_to '/' unless @owner
      
      @invoice = Invoice.find(params[:id])
      
      respond_to do |format|
        format.html {render layout: false}
        format.pdf
      end
    end

    private

    def generate_invoice(scharge, owner, scharge_invoice, scharge_refund=nil)
      amount, stripe_refund_id = scharge_invoice[:total], nil
      if scharge_refund.present?
        amount = -scharge_refund.amount #'-' For refund
        stripe_refund_id = scharge_refund.id
      end

      Invoice.create({
        stripe_id: scharge_invoice.id,
        owner_id: owner.id, 
        date: scharge.created, 
        invoice_number: "ls-#{Date.today.year}-#{(Invoice.last ? (Invoice.last.id * 7) : 1).to_s.rjust(5, '0')}", 
        json: scharge_invoice,
        amount: amount,
        stripe_refund_id: stripe_refund_id #We need to kept complet json of refund instead of only amount and id.
      })
    end

  end
end
