defmodule Checkout do
  alias Checkout.PricingRules.{GetTwoPayOne, BulkBuy, Default}

  @pricing_rules %{
    "VOUCHER" => GetTwoPayOne,
    "TSHIRT"  => BulkBuy,
    "MUG"     => Default
  }
  defstruct rules: @pricing_rules, cart: Map.new

  def scan(checkout, product_code) do
    case Checkout.Products.find_by_code(product_code) do
      {:ok , product} ->
        cart = add_product_to_cart(checkout, product)
        struct(checkout, cart: cart)
      :error -> IO.puts "Couldn't add the product: #{product_code} do not exists"
    end
  end

  def total(%Checkout{rules: rules, cart: cart}) do
    cart
    |> Enum.reduce(0.0, fn({_, line_item}, acc) ->
      acc + Map.get(rules, line_item.product["code"], Default).call(line_item)
    end)
  end

  defp add_product_to_cart(%Checkout{rules: _, cart: cart}, product) do
    case Map.get(cart, product["code"]) do
      nil ->
        line_item = %Checkout.LineItem{product: product}
        add_new_product_to_cart(cart, product["code"], line_item)
      line_item ->
        update_product_quantity(cart, product["code"], line_item)
    end
  end

  defp update_product_quantity(cart, product_code, line_item) do
    line_item = struct(line_item, quantity: (line_item.quantity + 1))

    cart
    |> Map.put(product_code, line_item)
  end

  defp add_new_product_to_cart(cart, product_code, line_item) do
    cart
    |> Map.put_new(product_code, line_item)
  end
end
