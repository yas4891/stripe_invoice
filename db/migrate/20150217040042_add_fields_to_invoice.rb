class AddFieldsToInvoice < ActiveRecord::Migration
  def change
    add_column :stripe_invoice_invoices, :total, :integer
    add_column :stripe_invoice_invoices, :subtotal, :integer
    add_column :stripe_invoice_invoices, :discount, :integer
    add_column :stripe_invoice_invoices, :period_start, :integer
    add_column :stripe_invoice_invoices, :period_end, :integer
    add_column :stripe_invoice_invoices, :currency, :string
  end
end
