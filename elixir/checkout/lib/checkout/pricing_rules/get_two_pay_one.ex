defmodule Checkout.PricingRules.GetTwoPayOne do
  def call(%Checkout.LineItem{product: product, quantity: quantity}) do
    product["price"] * (quantity - div(quantity, 2))
  end
end
