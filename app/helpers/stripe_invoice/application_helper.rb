module StripeInvoice
  module ApplicationHelper
    
    def format_timestamp(timestamp)
      dt = timestamp
      
      unless timestamp.is_a? DateTime
        dt = Time.at(timestamp).to_datetime
      end
      
      l(dt, :format => :short_date)
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
