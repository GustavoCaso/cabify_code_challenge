defmodule Checkout.ProductsTest do
  use ExUnit.Case

  test "find product by code" do
    { :ok, voucher } = Checkout.Products.find_by_code("VOUCHER")
    assert "VOUCHER" == voucher["code"]
  end

  test "if no product exists returns :error" do
    assert :error == Checkout.Products.find_by_code("STICKER")
  end
end
