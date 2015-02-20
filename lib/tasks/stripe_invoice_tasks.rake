# desc "Explaining what the task does"
# task :stripe_invoice do
#   # Task goes here
# end

namespace :stripe_invoice do
  task :generate => :environment do
    #StripeInvoice::Charge.all.each(&:destroy)
    
    Stripe::Charge.each do |charge|
      begin 
      StripeInvoice::Charge.create_from_stripe charge
      rescue => e
        puts "skipping charge for customer_id: #{charge.customer}"
        raise
      end # begin/rescue/end
    end
  end # task :generate
  
  task(:tax_report => :environment) do
    #Delayed::Job.enqueue StripeInvoice::DJTaxReport.new
    StripeInvoice::DJTaxReport.new(2015).perform
  end
end