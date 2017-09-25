defmodule Checkout.PricingRules.Default do
  def call(%Checkout.LineItem{product: product, quantity: quantity}) do
    product["price"] * quantity
  end
end
