class AddFieldsIntoStripeInvoiceInvoices < ActiveRecord::Migration
  def up
  	add_column :stripe_invoice_invoices, :amount, :integer, :default => 0
  	add_column :stripe_invoice_invoices, :stripe_refund_id, :string
  end

  def down
  	remove_column :stripe_invoice_invoices, :amount
  	remove_column :stripe_invoice_invoices, :stripe_refund_id
  end
end
