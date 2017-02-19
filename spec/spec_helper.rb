# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'
require 'koudoku'
require 'pry'
require 'pdf/inspector'
require 'vcr'

Rails.backtrace_cleaner.remove_silencers!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]
  FactoryGirl.find_definitions

  #Stipe configuration
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
end

# class ::Hash
#   # add keys to hash
#   def to_obj
#     self.each do |k,v|
#       if v.kind_of? Hash
#         v.to_obj
#       end
#       k=k.gsub(/\.|\s|-|\/|\'/, '_').downcase.to_sym

#       ## create and initialize an instance variable for this key/value pair
#       self.instance_variable_set("@#{k}", v)

#       ## create the getter that returns the instance variable
#       self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})

#       ## create the setter that sets the instance variable
#       self.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})
#     end
#     return self
#   end
# end