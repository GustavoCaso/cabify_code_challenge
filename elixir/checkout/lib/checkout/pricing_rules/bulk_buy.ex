defmodule Checkout.PricingRules.BulkBuy do
  require IEx
  @new_price 19.00
  @min_quantity 3

  def call(%Checkout.LineItem{product: product, quantity: quantity}) do
    if quantity < @min_quantity do
      product["price"] * quantity
    else
      @new_price * quantity
    end
  end
end
