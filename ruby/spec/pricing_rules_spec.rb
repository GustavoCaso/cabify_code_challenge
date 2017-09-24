require_relative '../lib/pricing_rules'
require_relative '../lib/product'

RSpec.describe PricingRules do
  include_context 'line_items'
  subject { described_class }

  context '#call' do
    it 'select correct pricing rule for line_item' do
      expect(PricingRules::VoucherGetTwoGetOneFree).to receive(:call).with(2, voucher_line_item)
      subject.call(2, voucher_line_item)
    end

    it 'if no rule found it will fallback to Default' do
      expect(PricingRules::Default).to receive(:call).with(2, mug_line_item)
      subject.call(2, mug_line_item)
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
