module StripeInvoice
  class DJTaxReport
    def initialize(year = 1.year.ago.year)
      @year = year
    end
    
    
    def perform
      puts "[DJTaxReport] computing tax report for #{@year}"
      
      sicharges = StripeInvoice::Charge.where(
            "date >= ? and date <= ?", 
            date_to_epoch("#{@year}-01-01"), 
            date_to_epoch("#{@year}-12-31"))
            
      puts "[DJTaxReport] number of charges in year: #{sicharges.size}"
      arr_data = []
      sicharges.each do |charge|
        owner = Koudoku.owner_class.find(charge.owner_id)
        
        next unless owner # skip if we don't have an owner
        
        data = {
          charge: charge,
          bt: Stripe::BalanceTransaction.retrieve(charge.indifferent_json[:balance_transaction]),
          owner: owner
        }
        puts "[DJTaxReport] aggregating data #{charge.stripe_id}"
        if charge.indifferent_json[:refunds].count > 0
          arr_refunds = []
          charge.indifferent_json[:refunds].each do |refund|
            refd = {
              refund: refund,
              bt: Stripe::BalanceTransaction.retrieve(refund[:balance_transaction])
            }
            arr_refunds << refd
          end
          
          data[:refunds] = arr_refunds
          #puts "[DJTaxReport] charge had refunds: #{arr_refunds}"
        end # has refunds
        
        arr_data << data
      end
      
      puts "[DJTaxReport] data collected; rendering view"
      #res = InvoicesController.new.tax_report arr_data
      res = Renderer.render template: "stripe_invoice/invoices/tax_report", 
            locals: {sicharges: arr_data, year: @year, totals: totals(arr_data)}, 
            formats: [:pdf]
      
      #InvoiceMailer.tax_report.deliver!
    end
    
    
    private 
    def date_to_epoch(date)
      Date.strptime(date,"%Y-%m-%d").to_datetime.utc.to_i
    end
    
    def totals(sicharges)
      result = {
        transaction_volume: total_transaction_volume(sicharges),
      }
    end
    
    include ActionView::Helpers::NumberHelper
    def total_transaction_volume(sicharges)
      number_to_currency(sicharges.inject(0) {|sum, hash_ch| sum + hash_ch[:bt][:amount]} / 100.0, 
        unit: "#{sicharges.first[:bt][:currency].upcase} ")
    end
  end
end
