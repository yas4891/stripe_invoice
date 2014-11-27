pdf.font("Times-Roman") #Prawn does not support Arial.
pdf.fill_color "333333"
pdf.font_size = 16

#Invoice Details Container
pdf.font_size(17.5) { pdf.text "Invoice Details", :style => :bold }

pdf.move_down 10

invoiceinfo = [['Date', "#{pdf_date_format(@invoice.date)}"],
		["Invoice #", "#{@invoice.invoice_number}"],
		["Billed To", "[BILLED TO]"],
		["VAT ID ", "[VAT-ID]"]]

pdf.table(invoiceinfo,:cell_style => { :border_width => 0,:border_color=> 'C1C1C1', :width=>'100%' }) do |table|
    table.column(0..1).style(:align => :left)
    table.column(0).width = 150
    table.column(1).width = 390
    table.row(0..3).style(:border_width => 1, :borders => [:top], :color => 'dddddd')
end
pdf.move_down 20

#Summary Container
pdf.font_size(17.5) { pdf.text "Summary", :style => :bold }
pdf.move_down 10

total = [['Subtotal', "#{format_currency(@invoice.subtotal, @invoice.currency)}"],
        ["Total", "#{format_currency(@invoice.amount, @invoice.currency)}"]]
pdf.table(total,:cell_style => { :border_width => 0,:border_color=> 'C1C1C1', :width=>'100%' }) do |table|
    table.column(0..1).style(:align => :right)
    table.column(0).width = 300
    table.column(1).width = 240
    table.row(0..1).style(:border_width => 1, :borders => [:top], :color => 'dddddd')
end
pdf.move_down 30

#Line Items Container
pdf.font_size(17.5) { pdf.text "Line Items", :style => :bold }
pdf.move_down 10

line_items = [["#{pluralize(plan_duration_in_month(@invoice), 'month')} LinksSpy.com subscription [plan: #{@invoice["json"]["lines"]["data"][0]["plan"]["name"]}]", "#{pdf_date_format(@invoice.period_start)} - #{pdf_date_format(@invoice.period_end)}", "#{format_currency(@invoice.total, @invoice.currency)}"]]
pdf.font_size = 14

pdf.table(line_items,:cell_style => { :border_width => 0,:border_color=> 'C1C1C1', :width=>'100%' }) do |table|
    table.column(0).style(:align => :left)
    table.column(1).style(:align => :center)
    table.column(2).style(:align => :right)
    table.column(0).width = 330
    table.column(1).width = 150
    table.column(2).width = 60
    table.row(0).style(:border_width => 1, :borders => [:top], :color => 'dddddd')
end
