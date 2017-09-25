defmodule CheckoutTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Checkout.PricingRules.{GetTwoPayOne, BulkBuy, Default}

  test "prints message when invalid product code is scanned" do
    execute_main = fn ->
      checkout = %Checkout{}
      Checkout.scan(checkout, "STICKER")
    end

    assert capture_io(execute_main) =~ "Couldn't add the product: STICKER"
  end

  describe "rules" do
    test "set default pricing rules" do
      checkout = %Checkout{}
      rules = checkout.rules
      default_rules = %{
        "MUG" => Default,
        "TSHIRT" => BulkBuy,
        "VOUCHER" => GetTwoPayOne
      }
      assert rules == default_rules
    end

    test "Rules can be set at initialization" do
      new_rules = %{
        "VOUCHER" => Default,
        "TSHIRT" => Default,
        "MUG" => GetTwoPayOne
      }
      checkout = %Checkout{rules: new_rules}
      assert checkout.rules == new_rules
    end
  end

  describe "cart" do
    test "set default as an empty Map" do
      checkout = %Checkout{}
      assert %{} == checkout.cart
    end
  end

  describe "Checkout.scan/2" do
    test "adds product to checkout cart" do
      checkout = %Checkout{}
      ch = Checkout.scan(checkout, "VOUCHER")
      voucher_line_item = Map.get(ch.cart, "VOUCHER")
      assert 1 == voucher_line_item.quantity
    end

    test "adds product and updates quantity of existing line_items" do
      checkout = %Checkout{}
      ch = Checkout.scan(checkout, "VOUCHER")
      ch = Checkout.scan(ch, "VOUCHER")
      ch = Checkout.scan(ch, "TSHIRT")
      voucher_line_item = Map.get(ch.cart, "VOUCHER")
      tshirt_line_item = Map.get(ch.cart, "TSHIRT")
      assert 2 == voucher_line_item.quantity
      assert 1 == tshirt_line_item.quantity
    end
  end

  describe "Checkout.total/1" do
    test "if no pricing rule found will fallback to Default" do
      checkout = %Checkout{rules: %{}}
      ch = Checkout.scan(checkout, "VOUCHER") # 5.00
      ch = Checkout.scan(ch, "VOUCHER") # 5.00
      ch = Checkout.scan(ch, "MUG") # 7.5
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      total = Checkout.total(ch)
      assert 77.5 == total
    end

    test "example 1" do
      checkout = %Checkout{}
      ch = Checkout.scan(checkout, "VOUCHER") # 5.00
      ch = Checkout.scan(ch, "MUG") # 7.5
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      total = Checkout.total(ch)
      assert 32.5 == total
    end

    test "example 2" do
      checkout = %Checkout{}
      ch = Checkout.scan(checkout, "VOUCHER") # 5.00
      ch = Checkout.scan(ch, "VOUCHER") # 5.00
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      total = Checkout.total(ch)
      assert 25.0 == total
    end

    test "example 3" do
      checkout = %Checkout{}
      ch = Checkout.scan(checkout, "VOUCHER") # 5.00
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      total = Checkout.total(ch)
      assert 81.0 == total
    end

    test "example 4" do
      checkout = %Checkout{}
      ch = Checkout.scan(checkout, "VOUCHER") # 5.00
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      ch = Checkout.scan(ch, "VOUCHER") # 5.00
      ch = Checkout.scan(ch, "VOUCHER") # 5.00
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      ch = Checkout.scan(ch, "TSHIRT") # 20.0
      ch = Checkout.scan(ch, "MUG") # 7.5
      total = Checkout.total(ch)
      assert 74.5 == total
    end
  end
end
