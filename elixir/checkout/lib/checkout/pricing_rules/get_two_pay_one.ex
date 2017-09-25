defmodule Checkout.PricingRules.GetTwoPayOne do
  @behaviour Checkout.PricingRule

  def call(%Checkout.LineItem{product: product, quantity: quantity}) do
    product["price"] * (quantity - div(quantity, 2))
  end
end
