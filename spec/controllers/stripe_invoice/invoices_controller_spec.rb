require 'spec_helper'

describe "StripeInvoice::InvoicesController" do
  let(:invoice) {FactoryGirl.create(:invoice)}

  # let(:subscription) {{id: 2, stripe_id: "cus_55dfC5lHHzhyl3", plan_id: 1, last_four: "1111", coupon_id: nil, card_type: "undefined", current_price: 10.0, user_id: 2, created_at: "2014-11-05 11:55:28", updated_at: "2014-11-05 11:55:28"}}
  # context 'Index action', :vcr do
  #   before do
  #     ::Koudoku.stub(:subscriptions_owned_by).and_return(:user)
  #     ApplicationController.any_instance.stub(:current_user).and_return({id: 1, email: "ankur@mail.com", encrypted_password: "$2a$10$13AxhtcJM76hKRjTh/0VfOT0cQ0ScqL.Q.vM6AXRE9O5...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2014-11-03 11:50:22", last_sign_in_at: "2014-11-03 11:50:22", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", created_at: "2014-11-03 11:50:22", updated_at: "2014-11-03 11:50:23", subscription: subscription}.with_indifferent_access.to_obj)
  #   end

  #   it "should  generate all the invoice from charges & refunds" do
  #     VCR.use_cassette 'get_all_charges' do
  #       visit "/stripe_invoice/invoices"
  #       expect(response).to render_template(:index)
  #       expect(StripeInvoice::Invoice.count).to eq(11)
  #     end
  #   end
  # end

  context 'Show action' do
    before do
      ::Koudoku.stub(:subscriptions_owned_by).and_return(:user)
      ApplicationController.any_instance.stub(:current_user).and_return({id: 1, email: "ankur@mail.com", encrypted_password: "$2a$10$13AxhtcJM76hKRjTh/0VfOT0cQ0ScqL.Q.vM6AXRE9O5...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2014-11-03 11:50:22", last_sign_in_at: "2014-11-03 11:50:22", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", created_at: "2014-11-03 11:50:22", updated_at: "2014-11-03 11:50:23"})
      visit "/stripe_invoice/invoices/#{invoice.id}.pdf"
      @ext_analysis = PDF::Inspector::Text.analyze(page.body)
    end

    context 'Invoice PDF' do

      it "Should download the pdf when visiting the show page" do
        expect(response).to render_template(:show)
        expect(page.response_headers['Content-Type']).to eq("application/pdf; charset=utf-8")
      end

      ['Invoice #', 'Invoice Details', 'Billed To', 'VAT ID',
         'Summary', 'Subtotal', 'Total', 'Line Items'].each do |pdf_text|
        it "The pdf should have the correct label : #{pdf_text}" do
          expect(@ext_analysis.strings).to include(pdf_text)
        end
      end

      # To check the value on the pdf
      it "The pdf should have the correct values" do    
        ["#{Time.at(invoice.date).strftime('%d/%m/%Y')}",
          invoice.invoice_number,
          "[BILLED TO]",
          "[VAT-ID]",
          "#{Time.at(invoice.period_start).strftime('%d/%m/%Y')} - #{Time.at(invoice.period_end).strftime('%d/%m/%Y')}"
        ].each do |pdf_value|
          expect(@ext_analysis.strings).to include(pdf_value)
        end
      end
    end

  end
end
