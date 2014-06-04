# shamelessly plugged from koudoku (http://github.com/andrewculver/koudoku)

require "stripe_invoice/engine"

require 'generators/stripe_invoice/install_generator'
require 'generators/stripe_invoice/views_generator'
module StripeInvoice
  mattr_accessor :webhooks_api_key
  @@webhooks_api_key = nil
  
  mattr_accessor :subscriptions_owned_by
  @@subscriptions_owned_by = nil
  
  def self.setup
    yield self
    
  end
  
  # e.g. :users
  def self.owner_resource
    subscriptions_owned_by.to_s.pluralize.to_sym
  end
  
  # e.g. :user_id
  def self.owner_id_sym
    # e.g. :user_id
    (subscriptions_owned_by.to_s + '_id').to_sym
  end
  
  def self.owner_assignment_sym
    # e.g. :user=
    (subscriptions_owned_by.to_s + '=').to_sym
  end

  # e.g. Users
  def self.owner_class
    # e.g. User
    subscriptions_owned_by.to_s.classify.constantize
  end
end
