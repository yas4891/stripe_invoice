Rails.application.routes.draw do

  mount StripeInvoice::Engine => "/stripe_invoice"
end
