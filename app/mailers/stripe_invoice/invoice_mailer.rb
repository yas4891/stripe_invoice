module StripeInvoice
  class InvoiceMailer < ActionMailer::Base
  
    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.invoice_mailer.new_invoice.subject
    #
    def new_invoice(charge)
      @charge = charge
      
  
      mail subject: "new #{I18n.t("config.stripe_invoice.app_name")} invoice available", to: @charge.owner.email
    end
    
    def refund_invoice(charge)
      @charge = charge
      
      mail subject: "We refunded your #{I18n.t("config.stripe_invoice.app_name")} charge", to: @charge.owner.email
    end
    
    
    def tax_report
      attachments['tax-report.pdf'] = {
        content: File.read(::Rails.root.join('tmp', 'tax_report.pdf')),
        mime_type: "application/pdf"
      }
      
      # sends the email to the default from address
      addr_to = ActionMailer::Base.default[:from]
      mail subject: "Tax report", to: addr_to 
      puts "[InvoiceMailer] tax report sent to #{addr_to}"
    end
  end
end
