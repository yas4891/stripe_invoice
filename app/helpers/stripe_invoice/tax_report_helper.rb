module StripeInvoice
  module TaxReportHelper
    
    # takes a Stripe JSON hash and an attribute name and returns a 
    # nicely formatted string for that currency 
    def format_stripe_currency(obj, attr_sym = :amount)
      number_to_currency(obj[attr_sym].to_f / 100, unit: "#{obj[:currency].upcase} ")
    end
    
  end
end
