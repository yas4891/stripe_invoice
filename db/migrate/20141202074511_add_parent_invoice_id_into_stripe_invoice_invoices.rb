class AddParentInvoiceIdIntoStripeInvoiceInvoices < ActiveRecord::Migration
  def up
  	add_column :stripe_invoice_invoices, :parent_invoice_id, :integer
  end

  def down
  	remove_column :stripe_invoice_invoices, :parent_invoice_id
  end
end
