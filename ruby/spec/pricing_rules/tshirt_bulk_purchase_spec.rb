require_relative '../../lib/pricing_rules/tshirt_bulk_purchase'
require_relative '../../lib/product'

RSpec.describe PricingRules::TshirtBulkPurchase do
  include_context 'line_items'
  subject { described_class }

  context '#match?' do
    it 'retruns false if no tshirt' do
      expect(subject.match?(mug_line_item)).to be_falsy
    end
    it 'retruns true if tshirt' do
      expect(subject.match?(tshirt_line_item)).to be_truthy
    end
  end

  context '#call' do
    it 'returns correct price if pricing rule apply' do
      expect(subject.call(3, tshirt_line_item)).to eq 57.00
    end

    it 'returns correct price if pricing rule do not apply' do
      expect(subject.call(2, tshirt_line_item)).to eq 40.00
    end
  end
end
