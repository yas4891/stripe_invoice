prawn_document(:page_layout => :portrait) do |pdf|

    pdf.font("Times-Roman") #Prawn does not support Arial.
    pdf.fill_color "333333"
    pdf.font_size = 14
    
    pdf.font_size(17.5) { pdf.text "Tax Report", :style => :bold }
    
    
    pdf.move_down 10
    pdf.text "Total charges in #{year}: #{sicharges.size}"
    pdf.text "Total transactions: #{totals[:transaction_volume]}"
    pdf.start_new_page
    sicharges.each do |hash_ch|
        pdf.text "Invoice: #{hash_ch[:charge].invoice_number}" + 
                " (on #{format_timestamp(hash_ch[:charge].datetime)})"
                
        pdf.text "Charged: #{format_stripe_currency(hash_ch[:charge], :total)}"
        pdf.text "Transaction: #{format_stripe_currency(hash_ch[:bt])} (Fee: #{format_stripe_currency(hash_ch[:bt],:fee)})"
        pdf.text "Billed to: #{format_billing_address hash_ch[:owner]}"
        pdf.text "Customer tax number: #{hash_ch[:owner].tax_number}" unless hash_ch[:owner].tax_number.blank?
        if hash_ch[:refunds]
            ref_text = "<b>Refunds:</b>\n"
            hash_ch[:refunds].each do |hash_refund|
                ref_text += "#{format_stripe_currency(hash_refund[:refund], :amount)} " + 
                        "on #{format_timestamp(hash_refund[:refund][:created])} " + 
                        "(Transaction: #{format_stripe_currency(hash_refund[:bt])}; " + 
                        "Fee: #{format_stripe_currency(hash_refund[:bt], :fee)})\n"
            end
            pdf.text ref_text, inline_format: true
        end 
        pdf.move_down 10
        pdf.stroke_horizontal_rule
        pdf.move_down 10
    end
    
    pdf.render_file ::Rails.root.join('tmp','tax_report.pdf')
end