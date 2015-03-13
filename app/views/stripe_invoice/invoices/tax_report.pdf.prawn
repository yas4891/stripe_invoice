prawn_document(:page_layout => :portrait) do |pdf|

    pdf.font("Times-Roman") #Prawn does not support Arial.
    pdf.fill_color "333333"
    pdf.font_size = 14
    
    pdf.font_size(17.5) { pdf.text "Income Report", :style => :bold }
    pdf.text "DO NOT USE THIS DATA FOR REPORTING TO YOUR TAX AUTHORITY OR ANYTHING WHERE THAT DATA NEEDS TO BE ACCURATE." + 
        "I CAN NOT BE HELD ACCOUNTABLE FOR ANY DAMAGE DONE FROM USING THIS DATA"
    
    pdf.move_down 10
    pdf.text "Total charges in #{year}: #{sicharges.size}"
    pdf.text "Total transactions: #{totals[:transaction_volume]}"
    
    rows = [["Country", "Transaction volume"]]
    bt_unit = sicharges.first[:bt][:currency].upcase
    totals[:transaction_volume_by_country].each do |country, volume|
     rows << [country, number_to_currency(volume, unit: "#{bt_unit} ")]
    end
    
    pdf.table(rows,:cell_style => { :border_width => 1,:border_color=> 'C1C1C1', :width=>'100%' }) do |table|
        table.column(0).style(:align => :left)
        table.column(1).style(:align => :right)
        table.column(0).width = 320
        table.column(1).width = 140
        table.row(0).style(:border_width => 1, :borders => [:top], :color => 'dddddd')
    end
    
    pdf.start_new_page
    sicharges.each do |hash_ch|
        pdf.text "Invoice: #{hash_ch[:charge].invoice_number}" + 
                " (on #{format_timestamp(hash_ch[:charge].datetime)})"
                
        pdf.text "Charged: #{format_stripe_currency(hash_ch[:charge], :total)}"
        pdf.text "Transaction: #{format_stripe_currency(hash_ch[:bt])} (Fee: #{format_stripe_currency(hash_ch[:bt],:fee)})"
        pdf.text "Billed to: #{hash_ch[:billing_address]}"
        pdf.text "Customer tax number: #{hash_ch[:tax_number]}" unless hash_ch[:tax_number].blank?
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