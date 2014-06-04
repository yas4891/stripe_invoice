
require 'rails/generators'

module StripeInvoice
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path("../../../../app/views/stripe_invoice/invoices", __FILE__)
    desc "installs stripe_invoice"
    
    def install
      unless defined?(StripeInvoice)
        gem 'stripe_invoice'
      end
      
      api_key = SecureRandom.uuid
      
      create_initializer api_key
      say "Your webhooks API key is: #{api_key}"
    end
    
    def create_initializer(api_key)
      create_file 'config/initializers/stripe_invoice.rb' do
      <<-RUBY
StripeInvoice.setup do |config|
  config.webhooks_api_key = "#{api_key}"
  config.subscriptions_owned_by = :user
end
RUBY
      end # create initializer file
    end # create_initializer
  end
end
