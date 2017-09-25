class LineItem
  attr_reader :product, :quantity
  def initialize(product)
    @product = product
    @quantity = 1
  end

  def increase
    @quantity += 1
  end
end
