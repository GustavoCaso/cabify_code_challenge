defmodule Checkout.PricingRules.GetTwoPayOneTest do
  use ExUnit.Case
  alias Checkout.PricingRules.GetTwoPayOne

  describe "call/1" do
    test "returns correct price when pricing rule apply" do
      line_item = %Checkout.LineItem{product: %{"price" => 5.00}, quantity: 4}
      result = GetTwoPayOne.call(line_item)
      assert 10.00 == result
    end

    test "returns correct price when pricing rule apply but add just one more" do
      line_item = %Checkout.LineItem{product: %{"price" => 5.00}, quantity: 3}
      result = GetTwoPayOne.call(line_item)
      assert 10.00 == result
    end

    test "returns correct price when pricing rule do not apply" do
      line_item = %Checkout.LineItem{product: %{"price" => 5.00}, quantity: 1}
      result = GetTwoPayOne.call(line_item)
      assert 5.00 == result
    end
  end
end
