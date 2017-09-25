require_relative './pricing_rules/voucher_get_two_get_one_free'
require_relative './pricing_rules/tshirt_bulk_purchase'
require_relative './pricing_rules/default'

module PricingRules
  module_function

  def call(line_item)
    rule = all.find { |r| r.match?(line_item) }
    rule ||= Default
    rule.call(line_item)
  end

  def all
    [
      VoucherGetTwoGetOneFree,
      TshirtBulkPurchase,
      Default
    ]
  end
end
