StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
    # we will create an invoice from this
    charge = StripeInvoice::Charge.create_from_stripe(event.data.object)
    StripeInvoice::InvoiceMailer.new_invoice(charge).deliver
  end
  
  events.subscribe 'charge.refunded' do |event|
    charge = StripeInvoice::Charge.create_from_stripe(event.data.object)
    StripeInvoice::InvoiceMailer.refund_invoice(charge).deliver
    
  end
end