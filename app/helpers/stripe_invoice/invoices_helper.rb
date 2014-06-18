module StripeInvoice
  module InvoicesHelper
    
    # nicely formats the amount and currency 
    def format_currency(amount, currency)
      
      currency = currency.upcase()
      # assuming that all currencies are split into 100 parts is probably wrong
      # on an i18n scale but it works for USD, EUR and LBP
      # TODO fix this maybe?
      amount = amount / 100
      options = {
        # use comma for euro 
        separator: currency == 'EUR' ? ',' : '.', 
        delimiter: currency == 'EUR' ? '.' : ',',
        format: currency == 'EUR' ? '%n %u' : '%u%n',
      }
      case currency
      when 'EUR'
        options[:unit] = '€' 
      when 'LBP'
        options[:unit] = '£'
      when 'USD'
        options[:unit] = '$'
      else
        options[:unit] = currency
      end
      return number_to_currency(amount, options)
    end
    
    alias_method :fc, :format_currency
    
    # checks the plan's metadata for a custom public name
    # and uses that if available - else it will use plan[:name]
    def plan_public_name(plan)
      plan = plan.with_indifferent_access
      (plan[:metadata] && 
        plan [:metadata][:stripe_invoice] && 
        plan[:metadata][:stripe_invoice][:public_name]) || plan[:name]
    end
  end
end
