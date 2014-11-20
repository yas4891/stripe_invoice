FactoryGirl.define do
  sequence :invoice_number do |n|
    "ls-2014-0#{n}"
  end

  factory :invoice, :class => StripeInvoice::Invoice do
    created_at Time.now
    date DateTime.now
    invoice_number 
    json {{
      "id" => "in_14ulSoD8GNoNEK6vB5oT8muW","date" => Time.now.to_i,"period_start" => Time.now.to_i,
      "period_end" => 10.days.from_now.to_i,
      "lines" => {"object" => "list","total_count" => 1,"has_more" => false,
        "url" => "/v1/invoices/in_14ulSoD8GNoNEK6vB5oT8muW/lines",
        "data" => [{"id" => "sub_54vJz44uQsUcT8","object" => "line_item",
          "type" => "subscription","livemode" => false,"amount" => 0,
          "currency" => "usd","proration" => false,
          "period" => {"start" => Time.now.to_i,"end" => 10.days.from_now.to_i},
          "subscription" => nil,"quantity" => 1,
          "plan" => {"id" => "3","interval" => "month","name" => "Enterprise",
              "created" => Time.now.to_i,"amount" => 111,"currency" => "usd",
              "object" => "plan","livemode" => false,"interval_count" => 1,
              "trial_period_days" => 10,"metadata" => {},
              "statement_description" => "test"},
          "description" => nil,"metadata" => {}}]
        },
      "subtotal" => 0,"total" => 0,"customer" => "cus_54vJXgyRP01m9B",
      "object" => "invoice","attempted" => true,"closed" => true,
      "forgiven" => false,"paid" => true,"livemode" => false,
      "attempt_count" => 0,"amount_due" => 0,"currency" => "usd",
      "starting_balance" => 0,"ending_balance" => 0,"next_payment_attempt" => nil,
      "webhooks_delivered_at" => Time.now.to_i,"charge" => nil,"discount" => nil,
      "application_fee" => nil,"subscription" => "sub_54vJz44uQsUcT8","metadata" => {},
      "statement_description" => nil,"description" => nil,"receipt_number" => nil
    }} #TODO:: Does this need to be randomized?
    owner_id 1 # Hardcoded as we do not have the user model here.
    stripe_id "in_14ulSoD8GNoNEK6vB5oT8muW"
    updated_at Time.now
  end
end
