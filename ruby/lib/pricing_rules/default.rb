module PricingRules
  module Default
    module_function

    def match?(line_item)
      false
    end

    def call(quantity, line_item)
      line_item.price * quantity
    end
  end
end
