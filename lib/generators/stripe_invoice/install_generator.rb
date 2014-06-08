
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
      
    # mounts StripeInvoice in the applications routes.rb file
      route "mount StripeInvoice::Engine, at: 'stripe_invoice'"

      api_key = SecureRandom.uuid
      
      create_file 'config/initializers/stripe_invoice.rb' do
      <<-RUBY
StripeInvoice.setup do |config|
  config.webhooks_api_key = "#{api_key}"
  config.subscriptions_owned_by = :user
end
RUBY
      end # create initializer file
      say "Your webhooks API key is: #{api_key}"
    end
    
    def copy_migrations
      rake("stripe_invoice:install:migrations")
    end 
  end
end
