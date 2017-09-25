defmodule Checkout.LineItem do
  defstruct product: Map.new, quantity: 1
  @type product :: map
  @type quantity :: integer

  @type t :: %__MODULE__{product: product,
                         quantity: quantity}
end
