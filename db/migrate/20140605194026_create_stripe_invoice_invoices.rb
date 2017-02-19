class CreateStripeInvoiceInvoices < ActiveRecord::Migration
  def change
    create_table :stripe_invoice_invoices, :force => true do |t|
      t.integer :id
      t.integer :owner_id
      t.string  :stripe_id
      t.string  :invoice_number
      t.integer :date
      t.text    :json

      t.timestamps
    end
  end
end
