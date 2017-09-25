defmodule Checkout.PricingRules.BulkBuyTest do
  use ExUnit.Case
  alias Checkout.PricingRules.BulkBuy

  describe "call/1" do
    test "returns correct price when pricing rule apply" do
      line_item = %Checkout.LineItem{product: %{"price" => 20.00}, quantity: 4}
      result = BulkBuy.call(line_item)
      assert 76.00 == result
    end

    test "returns correct price when quantity is at the edge(3)" do
      line_item = %Checkout.LineItem{product: %{"price" => 20.00}, quantity: 3}
      result = BulkBuy.call(line_item)
      assert 57.00 == result
    end

    test "returns correct price when pricing rule do not apply" do
      line_item = %Checkout.LineItem{product: %{"price" => 20.00}, quantity: 2}
      result = BulkBuy.call(line_item)
      assert 40.00 == result
    end
  end
end
