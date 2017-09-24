require 'yaml'
require_relative 'product'

module Products
  class NoProductsFile < StandardError; end
  class InvalidProductFileFormat < StandardError; end
  module_function

  def load(product_list_file)
    file = File.expand_path("#{product_list_file}.yml", __FILE__)
    product_list = YAML.load_file(file)

    if products = fetch_products(product_list)
      products.map { |product| Product.new(*product.values) }
    end
  rescue Errno::ENOENT => _
    raise NoProductsFile, "No products file in the system, please check the file #{product_list_file}.yml"
  end

  def fetch_products(product_list)
    products = product_list.fetch('products') { raise InvalidProductFileFormat }
    if products.all? { |product_info| (['code', 'name', 'price'] - product_info.keys).empty? }
      products
    else
      raise InvalidProductFileFormat
    end
  end
end
