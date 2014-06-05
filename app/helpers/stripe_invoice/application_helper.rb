module StripeInvoice
  module ApplicationHelper
    
    def format_timestamp(timestamp)
      l(Time.at(timestamp).to_datetime, :format => :short_date)
    end
    
    alias_method :ft, :format_timestamp
  end
end
