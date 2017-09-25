defmodule Checkout.LineItemTest do
  use ExUnit.Case

  test "have a default value of quantity to 1" do
    line_item = %Checkout.LineItem{}
    assert 1 == line_item.quantity
  end

  test "have a default value of product to empty Map" do
    line_item = %Checkout.LineItem{}
    assert %{} == line_item.product
  end
end
