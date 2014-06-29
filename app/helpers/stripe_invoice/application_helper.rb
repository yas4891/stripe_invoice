module StripeInvoice
  module ApplicationHelper
    
    def format_timestamp(timestamp)
      l(Time.at(timestamp).to_datetime, :format => :short_date)
    end
    
    alias_method :ft, :format_timestamp
    
    # returns TRUE if the controller belongs to StripeInvoice
    # false in all other cases, for convenience when executing filters 
    # in the main application
    def stripe_invoice_controller? 
      is_a? StripeInvoice::ApplicationController
    end
  end
end
