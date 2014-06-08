= StripeInvoice

StripeInvoice makes it easy for you to show invoices/receipts to the customers of your [Koudoku](https://github.com/andrewculver/koudoku/)-based Rails application. 
It downloads the last 100 invoices via the Stripe API, stores them in a table in the database and renders a basic 
invoice template. 

## Features

- Show invoices & receipts to your customers
- Automatically assign Invoice # for new invoices
- Download invoices as PDF

## Requirements 

StripeInvoice is opinionated on which gems your application uses. 

1. [Koudoku](https://github.com/andrewculver/koudoku/) to handle subscriptions
2. [Devise](https://github.com/plataformatec/devise) for user authentication

## Usage

### Installation

StripeInvoice is hosted on RubyGems.org. To use it, just add the following line to your `Gemfile` and run `bundle install`:

```
gem 'stripe_invoice'
```


To setup your application run the following commands from the command line: 

```
rails generator stripe_invoice:install
rake db:migrate
```

This will add necessary migrations to your application and run them. Additionally it will mount StripeInvoice into your application
at `/stripe_invoice`

### Accessing the invoices

To view the invoices log into your application

### Customizing the views

You probably want to customize the views for your application. You can easily install the views files (written with HAML)
to your application by running `rails g stripe_invoice:views` from the command line. 
The views will be installed into `app/views/stripe_invoice/invoices/` folder



## Contribution

To contribute to the development of StripeInvoice please: 

1. fork the repository
2. create a development branch
3. code away
4. send a pull request

## Developer
This plugin is under active development by [Christoph Engelhardt](http://www.it-engelhardt.de) and used at [LinksSpy.com](http://www.linksspy.com)