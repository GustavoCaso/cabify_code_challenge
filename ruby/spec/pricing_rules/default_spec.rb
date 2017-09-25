require_relative '../../lib/pricing_rules/default'
require_relative '../../lib/product'
require_relative '../../lib/line_item'

RSpec.describe PricingRules::Default do
  include_context 'products_and_line_items'
  subject { described_class }

  context '#match?' do
    it 'retruns false' do
      expect(subject.match?(voucher_line_item)).to be_falsy
    end
  end

  context '#call' do
    it 'returns correct price' do
      expect(subject.call(voucher_line_item)).to eq 10.00
    end
  end
end
