require_relative '../lib/cart'
require_relative '../lib/product'

RSpec.describe Cart do
  include_context 'line_items'
  subject { described_class.new }

  context '#line_items' do
    it 'initializes with empty line_items' do
      expect(subject.line_items).to eq []
    end
  end

  context '#add' do
    it 'adds a new line item' do
      subject.add(voucher_line_item)
      expect(subject.line_items).to include(voucher_line_item)
    end
  end

  context '#group_by_line_item' do
    before do
      subject.add(voucher_line_item)
      subject.add(voucher_line_item)
      subject.add(voucher_line_item)
      subject.add(mug_line_item)
    end

    let(:expect_result) do
      {
        voucher_line_item => 3,
        mug_line_item => 1
      }
    end

    it 'returns line_items and the total quantity of them' do
      expect(subject.group_by_line_item).to eq expect_result
    end
  end
end
