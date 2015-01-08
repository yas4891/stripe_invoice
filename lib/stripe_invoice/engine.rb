module StripeInvoice
  class Engine < ::Rails::Engine
    isolate_namespace StripeInvoice
    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
    
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        app.config.paths["db/migrate"] += config.paths["db/migrate"].expanded
      end
    end

    # loads StripeInvoice::ApplicationHelper into ::ApplicationController
    # so we can use #stripe_invoice_controller? in the main_app
    initializer 'load_stripe_invoice_helpers' do 
      ActiveSupport.on_load(:action_controller) do 
        include StripeInvoice::ApplicationHelper
      end
    end 
  end
end
