require 'stripe_event'
require 'stripe/api_operations_list'
require "stripe_invoice/engine"
require "stripe_invoice/renderer"
require "#{StripeInvoice::Engine.root}/app/delayed_jobs/stripe_invoice/dj_tax_report"

require 'generators/stripe_invoice/install_generator'
require 'generators/stripe_invoice/views_generator'

module StripeInvoice
  def self.setup
    yield self
  end
  
end
