### Elixir Version

## How to run

```elixir
mix deps.get
mix test
```

Inside the `iex`

```elixir
iex -S mix

checkout = %Checkout{}
ch = Checkout.scan(checkout, "VOUCHER")
ch = Checkout.scan(ch, "MUG")
ch = Checkout.scan(ch, "TSHIRT")
total = Checkout.total(ch)
# total 32.5
```


## How it works

The exercise has been written thinking in TDD.

The code is built with the idea of allowing to grow the functionality without making big changes.

The list of products is store in a `yml` file under `lib/product_list/standard.json`. I decided to use `json` instead of `yml` since the elixir community is more keen on using it.

All the pricing are stored under `lib/checkout/pricing_rules/` they all have to fullfil the `Checkout.PricingRule` behaviour which only implement the `call` function that accept a `LineItem` struct. To add a new one is very simple.

When creating a new `Checkout` you can use the default rules or pass a new set of rules.

The structure of the rules is:

```elixir
new_rules = %{
  "VOUCHER" => Checkout.PricingRules.Default,
  "TSHIRT" => Checkout.PricingRules.Default,
  "MUG" => Checkout.PricingRules.GetTwoPayOne
}

# been the key the code of a product and the value the module of the rule
```

This allow to easily change the functionality and change how the products interact with the different rules

## Thing left

- No persisted layer has been added, but adding would be that difficult since everything is very decoupled

- Only can rule can apply to one product, maybe in the future this requirement change.

- `Currency` haven't been consider since the exercise did not specify any, in the future would be interesting to store each `LineItem` with the currency
