RSpec.shared_context 'line_items' do
  let(:tshirt_line_item) { Product.new('TSHIRT', 'the new cabify tshirt', 20.00) }
  let(:voucher_line_item) { Product.new('VOUCHER', 'the new cabify voucher', 10.00) }
  let(:mug_line_item) { Product.new('MUG', 'the mug your coffee need', 7.00) }
end
