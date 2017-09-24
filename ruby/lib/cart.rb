class Cart
  attr_reader :line_items

  def initialize
    @line_items = []
  end

  def add(product)
    line_items << product
  end

  def group_by_line_item
    line_items.each_with_object({}) do |line_item, total|
      total[line_item] ||= 0
      total[line_item] = line_item_count(line_item)
    end
  end

  private
  attr_writer :line_items

  def line_item_count(line_item)
    line_items.select{ |item| item.code == line_item.code }.count
  end
end
