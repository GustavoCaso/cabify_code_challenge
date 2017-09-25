module PricingRules
  module TshirtBulkPurchase
    CODE = 'TSHIRT'.freeze
    MIN_QUANTITY = 3
    NEW_PRICE = 19.0

    module_function

    def match?(line_item)
      line_item.product.code == CODE
    end

    def call(line_item)
      quantity = line_item.quantity

      quantity >=  MIN_QUANTITY ? quantity * NEW_PRICE : line_item.product.price * quantity
    end
  end
end
