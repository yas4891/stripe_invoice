$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "stripe_invoice/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "stripe_invoice"
  s.version     = StripeInvoice::VERSION
  s.authors     = ["Christoph Engelhardt"]
  s.email       = ["christoph@it-engelhardt.de"]
  s.homepage    = "https://github.com/yas4891/stripe_invoice"
  s.summary     = "Adds views, PDFs and automated emails if you are using Stripe/Koudoku for payment processing"
  s.description = "stripe_invoice adds PDF views and automated emails to your Koudoku-based application"

  # s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  # s.test_files = Dir["spec/**/*"]
  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "rails", ">= 3.2.18", "< 5.0"
  s.add_dependency "stripe" 
  s.add_dependency "stripe_event" 
  s.add_dependency 'koudoku'
  s.add_dependency "prawn-rails"
  s.add_dependency "haml-rails" 
  s.add_dependency "delayed_job_active_record" # for tax reports
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'devise'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  # s.add_dependency "jquery-rails"
  s.add_development_dependency 'pry'

  s.add_development_dependency "sqlite3"
end
