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
        @stripe_invoices = Stripe::Invoice.all(
          :customer => @subscription.stripe_id,
          :limit => 100)
        
        @stripe_invoices.each do |sinvoice|
          next if Invoice.find_by_stripe_id(sinvoice.id)
          Invoice.create({
            stripe_id: sinvoice.id,
            owner_id: @owner.id, 
            date: sinvoice.date, 
            invoice_number: "ls-#{Date.today.year}-#{(Invoice.last ? (Invoice.last.id * 7) : 1).to_s.rjust(5, '0')}", 
            json: sinvoice
          })
        end
      end # if subscription
      
      @invoices = Invoice.where(owner_id: @owner.id).order('date DESC')
    end
    
    def show
      @owner = send("current_#{::Koudoku.subscriptions_owned_by}")
      redirect_to '/' unless @owner
      
      @invoice = Invoice.find(params[:id])
      
      respond_to do |format|
        format.html {render layout: false}
        format.pdf do
          # By default this gets routed to prawn.
        end
      end
    end
  end
end
