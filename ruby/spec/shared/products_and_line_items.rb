RSpec.shared_context 'products_and_line_items' do
  let(:tshirt_product) { Product.new('TSHIRT', 'the new cabify tshirt', 20.00) }
  let(:voucher_product) { Product.new('VOUCHER', 'the new cabify voucher', 10.00) }
  let(:mug_product) { Product.new('MUG', 'the mug your coffee need', 7.00) }

  let(:tshirt_line_item) { LineItem.new(tshirt_product) }
  let(:voucher_line_item) { LineItem.new(voucher_product) }
  let(:mug_line_item) { LineItem.new(mug_product) }
end
