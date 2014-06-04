
require 'rails/generators'

module StripeInvoice
  class ViewsGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root "#{StripeInvoice::Engine.root}/app/views/stripe_invoice/invoices"
    desc "installs stripe_invoice views into an application near you"
    
    def install
      say "copying StripeInvoice view files"
      view_files.each do |file|
        copy_file file, "app/views/stripe_invoice/#{file}"
      end
    end
    
    # returns all files for the invoice views
    def view_files
      Dir.entries(engine_directory_path) - %w[. ..]
    end
    
    # shortcut for the directory path
    def engine_directory_path
      "#{StripeInvoice::Engine.root}/app/views/stripe_invoice/invoices"
    end

  end
end
