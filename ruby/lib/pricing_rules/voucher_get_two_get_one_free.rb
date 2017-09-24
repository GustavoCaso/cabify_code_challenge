module PricingRules
  module VoucherGetTwoGetOneFree
    CODE = 'VOUCHER'.freeze

    module_function

    def match?(line_item)
      line_item.code == CODE
    end

    def call(quantity, line_item)
      quantity_amount = quantity/2
      calculated_quantity = quantity.odd? ? quantity_amount += 1 : quantity_amount
      line_item.price * calculated_quantity
    end
  end
end
