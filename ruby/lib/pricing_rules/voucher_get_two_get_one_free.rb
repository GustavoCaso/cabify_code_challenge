module PricingRules
  module VoucherGetTwoGetOneFree
    CODE = 'VOUCHER'.freeze

    module_function

    def match?(line_item)
      line_item.product.code == CODE
    end

    def call(line_item)
      quantity_amount = line_item.quantity/2
      calculated_quantity = line_item.quantity.odd? ? quantity_amount += 1 : quantity_amount

      line_item.product.price * calculated_quantity
    end
  end
end
