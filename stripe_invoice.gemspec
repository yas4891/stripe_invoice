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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.18"
  s.add_dependency "stripe" 
  s.add_dependency "pdfkit" 
  s.add_dependency "wkhtmltopdf-binary" 
  s.add_dependency "haml-rails" 
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
