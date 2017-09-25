defmodule Checkout.PricingRules.Default do
  @behaviour Checkout.PricingRule

  def call(%Checkout.LineItem{product: product, quantity: quantity}) do
    product["price"] * quantity
  end
end
