module PricingRules
  module Default
    module_function

    def match?(line_item)
      false
    end

    def call(line_item)
      line_item.product.price * line_item.quantity
    end
  end
end
