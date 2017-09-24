require_relative '../../lib/pricing_rules/voucher_get_two_get_one_free'
require_relative '../../lib/product'

RSpec.describe PricingRules::VoucherGetTwoGetOneFree do
  include_context 'line_items'
  subject { described_class }

  context '#match?' do
    it 'retruns false if no voucher' do
      expect(subject.match?(mug_line_item)).to be_falsy
    end
    it 'retruns true if voucher' do
      expect(subject.match?(voucher_line_item)).to be_truthy
    end
  end

  context '#call' do
    it 'returns correct price if pricing rule apply' do
      expect(subject.call(4, voucher_line_item)).to eq 20.00
    end

    it 'returns correct price if pricing rule do not apply' do
      expect(subject.call(1, voucher_line_item)).to eq 10.00
    end
  end
end
