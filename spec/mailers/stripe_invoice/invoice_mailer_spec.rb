require "rails_helper"

module StripeInvoice
  RSpec.describe InvoiceMailer, :type => :mailer do
    describe "new_invoice" do
      let(:mail) { InvoiceMailer.new_invoice }
  
      it "renders the headers" do
        expect(mail.subject).to eq("New invoice")
        expect(mail.to).to eq(["to@example.org"])
        expect(mail.from).to eq(["from@example.com"])
      end
  
      it "renders the body" do
        expect(mail.body.encoded).to match("Hi")
      end
    end
  
  end
end
