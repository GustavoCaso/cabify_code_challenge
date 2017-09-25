require_relative 'line_item'

class Cart
  attr_reader :line_items

  def initialize
    @line_items = []
  end

  def add(product)
    if line_item = find_line_item(product)
      line_item.increase
    else
      line_items << LineItem.new(product)
    end
  end

  private
  attr_writer :line_items

  def find_line_item(product)
    line_items.find { |item| item.product.code == product.code }
  end
end
