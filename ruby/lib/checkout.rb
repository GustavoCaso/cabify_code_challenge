require_relative 'products'
require_relative 'cart'
require_relative 'pricing_rules'

class Checkout
  class InvalidProductCode < StandardError; end

  attr_reader :cart, :pricing_rules

  def initialize(pricing_rules, product_list: '../../product_list/standard')
    @pricing_rules = pricing_rules
    @cart = Cart.new
    @product_list = product_list
  end

  def scan(code)
    if product = product(code)
      @cart.add(product)
    else
      raise InvalidProductCode
    end
  end

  def total
    @cart.line_items.map { |line_item| pricing_rules.call(line_item) }.reduce(:+)
  end

  private

  def products
    @products ||= Products.load(@product_list)
  end

  def product(code)
    products.find { |product| product.code == code }
  end
end
