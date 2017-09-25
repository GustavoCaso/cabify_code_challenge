require_relative '../../lib/pricing_rules/tshirt_bulk_purchase'
require_relative '../../lib/product'
require_relative '../../lib/line_item'

RSpec.describe PricingRules::TshirtBulkPurchase do
  include_context 'products_and_line_items'
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
    context 'Apply' do
      let(:line_item) do
        line_item = LineItem.new(tshirt_product)
        2.times { line_item.increase }
        line_item
      end

      it 'returns correct price if pricing rule apply' do
        expect(subject.call(line_item)).to eq 57.00
      end
    end

    context 'Not apply' do
      let(:line_item) do
        line_item = LineItem.new(tshirt_product)
        1.times { line_item.increase }
        line_item
      end
      it 'returns correct price if pricing rule do not apply' do
        expect(subject.call(line_item)).to eq 40.00
      end
    end
  end
end
