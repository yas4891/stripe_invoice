require 'spec_helper'

describe StripeInvoice::InvoicesController do

  context 'Invoice Pdf' do
    before do
      ::Koudoku.stub(:subscriptions_owned_by).and_return(:user)
    end

    it 'file should be available for view' do
      pending
      visit '/stripe_invoice/invoices/1.pdf'
      page.status_code.must_equal 200
    end
  end

  context 'The rendered pdf content' do
      let (:pdf_content) {} #TODO:: This needs to be a pdf reader object that reads the pdf downloaded

      it 'contains the Invoice info of subscription' do
        pending
        expect(pdf_content).to include('Invoice #')
        expect(pdf_content).to include('Invoice Details')
        expect(pdf_content).to include('Billed To') 
        expect(pdf_content).to include('VAT ID') 
      end
      
      it 'contains the Summary of subscription' do
        pending
        expect(pdf_content).to include('Summary')
        expect(pdf_content).to include('Subtotal')
        expect(pdf_content).to include('Total')
      end
      
      it 'contains the Line Items of subscription' do
        pending
        expect(pdf_content).to include('Line Items')
        expect(pdf_content).to include('subscription')
      end
  end
end