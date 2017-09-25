require_relative '../lib/pricing_rules'
require_relative '../lib/product'
require_relative '../lib/line_item'

RSpec.describe PricingRules do
  include_context 'products_and_line_items'
  subject { described_class }

  context '#call' do
    it 'select correct pricing rule for line_item' do
      expect(PricingRules::VoucherGetTwoGetOneFree).to receive(:call).with(voucher_line_item)
      subject.call(voucher_line_item)
    end

    it 'if no rule found it will fallback to Default' do
      expect(PricingRules::Default).to receive(:call).with(mug_line_item)
      subject.call(mug_line_item)
    end
  end

  context '#all' do
    it 'returns a list with all the pricing rules' do
      expect(subject.all).to eq [
        PricingRules::VoucherGetTwoGetOneFree,
        PricingRules::TshirtBulkPurchase,
        PricingRules::Default
      ]
    end
  end
end
