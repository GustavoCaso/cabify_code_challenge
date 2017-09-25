defmodule Checkout.PricingRules.DefaultTest do
  use ExUnit.Case
  alias Checkout.PricingRules.Default

  describe "call/1" do
    test "returns correct price when pricing" do
      line_item = %Checkout.LineItem{product: %{"price" => 5.00}, quantity: 4}
      result = Default.call(line_item)
      assert 20.00 == result
    end
  end
end
