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
  end
end
