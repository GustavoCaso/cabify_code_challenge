defmodule Checkout.Products do
  def find_by_code(product_code) do
    Map.fetch(products(), product_code)
  end

  def products do
    product_json_file()
    |> Poison.Parser.parse!()
  end

  defp product_json_file do
    {:ok, json_content } = File.read("lib/product_list/standard.json")
    json_content
  end
end
