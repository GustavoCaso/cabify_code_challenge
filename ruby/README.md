### Ruby Version

## How to run

```
bundle install
bundle exec rspec
```

Inside `irb`

```ruby
irb -I lib

> require 'checkout'

checkout = Checkout.new(PricingRules)

checkout.scan('VOUCHER')
checkout.scan('TSHIRT')
checkout.scan('MUG')

checkout.total # => 32.5
```

## How it works

The exercise has been written thinking in TDD.

The code is built with the idea of allowing to grow the functionality without making big changes.

The list of products is store in a `yml` file under `product_list/standard.yml`, by default the application use this file, but is easy to set a new one when instantiating a new instance of `Checkout` allowing the user to use different products or prices depending the occasion.

A crucial part of the application is the set of rules defined for special offers. They are stored in `lib/princing_rules/` you can add more rules easily by simply adding a new module with two methods `match?(line_item)` and `call(line_item)` and loading it from the main file in `lib/pricing_rules.rb` this allow for easy extension of the rules.

## Thing left

- No persisted layer has been added, but adding would be that difficult since everything is very decoupled

- Only can rule can apply to one product, maybe in the future this requirement change.

- `Currency` haven't been consider since the exercise did not specify any, in the future would be interesting to store each `LineItem` with the currency
