defmodule Checkout.PricingRule do
  @type line_item :: Checkout.LineItem.t

  @callback call(line_item) :: float
end
