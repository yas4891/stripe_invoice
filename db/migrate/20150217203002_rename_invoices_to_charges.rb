class RenameInvoicesToCharges < ActiveRecord::Migration
  def change
    say_with_time "Switching from Stripe-Invoice-objects to Stripe-Charge-objects" do
      rename_table :stripe_invoice_invoices, :stripe_invoice_charges
      execute "DELETE FROM stripe_invoice_charges WHERE 1=1"
    end
  end

end
