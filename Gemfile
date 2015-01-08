source "https://rubygems.org"

# Declare your gem's dependencies in stripe_invoice.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

gem 'stripe'
gem 'haml-rails'

gem 'prawn-rails'
 
group :development, :test do
	gem "rspec-rails", "~> 2.12.2"
	gem "factory_girl_rails", "~> 4.0"
	gem 'pdf-inspector'
  gem 'vcr'
  gem 'webmock'
end


# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
