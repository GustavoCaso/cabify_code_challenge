require_relative '../lib/cart'
require_relative '../lib/product'

RSpec.describe Cart do
  include_context 'products_and_line_items'
  subject { described_class.new }

  context '#line_items' do
    it 'initializes with empty line_items' do
      expect(subject.line_items).to eq []
    end
  end

  context '#add' do
    it 'adds a new line item' do
      subject.add(voucher_product)
      expect(subject.line_items.map(&:product)).to include(voucher_line_item.product)
    end

    context 'Increase Line Item quantity' do
      before do
        subject.add(voucher_product)
        subject.add(voucher_product)
        subject.add(voucher_product)
        subject.add(mug_product)
      end

      it 'increases the line_items correctly' do
        voucher = subject.line_items.find{ |item| item.product.code == 'VOUCHER' }
        mug = subject.line_items.find{ |item| item.product.code == 'MUG' }
        expect(voucher.quantity).to eq 3
        expect(mug.quantity).to eq 1
      end
    end
  end
end
